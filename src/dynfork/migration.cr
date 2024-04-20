# Migrations are DynFork way of
# propagating changes you make to
# your models (adding a field, deleting a collection, etc.) into
# your database schema.
module DynFork::Migration
  # To control the state of Models in the super collection.
  struct ModelState
    include BSON::Serializable

    getter collection_name : String
    property field_name_and_type_list : Hash(String, String)
    property data_dynamic_fields : Hash(String, String)
    property? model_exists : Bool

    def initialize(
      @collection_name : String,
      @field_name_and_type_list : Hash(String, String),
      @model_exists : Bool = false
    )
      @data_dynamic_fields = Hash(String, String).new
    end
  end

  # Monitoring and update the database state for the application.
  struct Monitor
    getter model_list : Array(DynFork::Model.class)

    def initialize(
      app_name : String,
      unique_app_key : String,
      mongo_uri : String,
      database_name : String = ""
    )
      # Update global storage state.
      DynFork::Globals.cache_app_name = app_name
      DynFork::Globals.cache_unique_app_key = unique_app_key
      unless database_name.empty?
        DynFork::Globals.cache_database_name = database_name
      end
      DynFork::Globals::ValidationCacheSettings.validation
      DynFork::Globals.cache_mongo_client = Mongo::Client.new mongo_uri
      DynFork::Globals.cache_mongo_database = DynFork::Globals
        .cache_mongo_client[DynFork::Globals.cache_database_name]
      # Get Model list.
      @model_list = DynFork::Model.subclasses.map { |model| model.meta[:migrat_model?] }
      if model_list.empty?
        raise DynFork::Errors::Panic.new("No Models for Migration!")
      end
    end

    # Update the state of Models in the super collection.
    private def refresh : Nil
      # Get super collection.
      # Contains model state and dynamic field data.
      super_collection = DynFork::Globals.cache_mongo_database[
        DynFork::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor : Mongo::Cursor = super_collection.find
      # Reset Models state information.
      cursor.each { |document|
        filter = {"collection_name": document["collection_name"]}
        update = {"$set": {"model_exists": false}}
        super_collection.update_one(filter, update)
      }
    end

    # Delete data for non-existent Models from a
    # super collection and delete collections associated with those Models.
    private def napalm : Nil
      # Get database of application.
      database : Mongo::Database = DynFork::Globals.cache_mongo_database
      # Get super collection - State of Models and dynamic field data.
      super_collection = database[DynFork::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor : Mongo::Cursor = super_collection.find
      # Delete data for non-existent Models.
      cursor.each { |document|
        unless document["model_exists"].as(Bool)
          # Get the name of the collection associated with the Model.
          model_collection_name : String = document["collection_name"].as(String)
          # Delete data for non-existent Model.
          super_collection.delete_one({"collection_name": model_collection_name})
          # Delete collection associated with non-existent Model.
          database.command(Mongo::Commands::Drop, name: model_collection_name)
        end
      }
    end

    # Run migration process.
    # <br>
    # 1) Update the state of Models in the super collection.
    # <br>
    # 2) Add models states to the super collection if missing.
    # <br>
    # 3) Check the changes in the models and (if necessary) apply to the database.
    # <br>
    # 4) Delete data for non-existent Models from a
    # super collection and delete collections associated with those Models.
    def migrat : Nil
      # Update the state of Models in the super collection.
      self.refresh
      # ------------------------------------------------------------------------
      #
      # Get database of application.
      database : Mongo::Database = DynFork::Globals.cache_mongo_database
      # Enumeration of keys for Model migration.
      @model_list.each do |model|
        # Run matadata caching.
        model.new
        # Get metadata of Model from cache.
        metadata : DynFork::Globals::CacheMetaDataType = model.meta
        # If the Model parameter `migrat_model?` is false, skip the iteration.
        next unless metadata[:migrat_model?]
        # Get super collection.
        # Contains model state and dynamic field data.
        super_collection : Mongo::Collection = database[
          DynFork::Globals.cache_super_collection_name]
        # Get ModelState for current Model.
        model_state = (
          filter = {"collection_name": metadata[:collection_name]}
          document = super_collection.find_one(filter)
          if !document.nil?
            # Get existing ModelState for the current Model.
            m_state = DynFork::Migration::ModelState.from_bson(document)
            m_state.model_exists = true
            m_state
          else
            # Create a new ModelState for current Model.
            m_state = DynFork::Migration::ModelState.new(
              "collection_name": metadata[:collection_name],
              "field_name_and_type_list": metadata[:field_name_and_type_list],
              "model_exists": true,
            )
            super_collection.insert_one(m_state.to_bson)
            database.command(Mongo::Commands::Create, name: m_state.collection_name)
            m_state
          end
        )
        # Review field changes in the current Model and (if necessary)
        # update documents in the appropriate Collection.
        if model_state.field_name_and_type_list != metadata[:field_name_and_type_list]
          # Get a list of default values.
          default_value_list = metadata[:default_value_list]
          # List of previous field names.
          old_fields : Array(String) = model_state.field_name_and_type_list.keys
          # Get a list of missing fields.
          missing_fields : Array(String) = old_fields -
            metadata[:field_name_and_type_list].keys
          # Get a list of new fields.
          new_fields = Array(String).new
          metadata[:field_name_and_type_list].each do |field_name, field_type|
            old_field_type : String? = model_state.field_name_and_type_list[field_name]?
            if old_field_type.nil? || old_field_type != field_type
              new_fields << field_name
            end
          end
          # Get collection for current Model.
          model_collection : Mongo::Collection = database[metadata[:collection_name]]
          # Fetch a Cursor pointing to the collection of current Model.
          cursor : Mongo::Cursor = model_collection.find
          # Go through all documents to make changes.
          cursor.each { |doc|
            # Create a new document for the updated state.
            freshed_document = {"_id" => doc["_id"]}
            # Create a new document without the deleted fields.
            old_fields.each do |field_name|
              unless missing_fields.includes?(field_name)
                freshed_document[field_name] = doc[field_name]
              end
            end
            # Add new fields with default value or
            # update existing fields whose field type has changed.
            new_fields.each do |field_name|
              doc[field_name] = (
                if metadata[:field_name_and_type_list][field_name].includes?("Date")
                  metadata[:time_object_list][field_name][:default]
                else
                  default_value_list[field_name]
                end
              )
            end
            # Update document.
            filter = {"_id": freshed_document["_id"]}
            update = {"$set": freshed_document}
            model_collection.update_one(filter, update)
          }
        end
        #
        # **Update dynamic fields data in ModelState:**
        # <br>
        # <br>
        # Get a list of names of current dynamic fields.
        current_dynamic_fields : Array(String) = metadata[:field_name_and_type_list]
          .select { |_, field_type| field_type.includes?("Dyn") }.keys
        # Remove missing dynamic fields.
        model_state.data_dynamic_fields
          .select! { |field_name, _| current_dynamic_fields.includes?(field_name) }
        # Add new dynamic fields.
        current_dynamic_fields.each do |field_name|
          unless model_state.data_dynamic_fields.includes?(field_name)
            model_state.data_dynamic_fields[field_name] = "[]"
          end
        end #
        # Update metadata of the current Model.
        model_state.data_dynamic_fields.each do |field_name, choices_json|
          model.meta[:data_dynamic_fields][field_name] = choices_json
        end
        #
        # ----------------------------------------------------------------------
        # Update list.
        model_state.field_name_and_type_list = metadata[:field_name_and_type_list]
        # Update the state of the current Model.
        filter = {"collection_name": model_state.collection_name}
        update = {"$set": model_state}
        super_collection.update_one(filter, update)
      end
      #
      # ------------------------------------------------------------------------
      # Delete data for non-existent Models from a
      # super collection and delete collections associated with those Models.
      self.napalm
      #
      # Run indexing.
      @model_list.each do |model|
        if model.meta[:migrat_model?]
          # Run indexing.
          model.indexing
          # Apply a fixture to the Model.
          if fixture_name = model.meta[:fixture_name]
            collection = DynFork::Globals.cache_mongo_database[
              model.meta[:collection_name]]
            if collection.estimated_document_count == 0
              curr_model = model.new
              curr_model.apply_fixture(
                fixture_name: fixture_name,
                collection_ptr: pointerof(collection),
              )
            end
          end
        else
          raise DynFork::Errors::Panic.new(
            "Model : `#{model.full_model_name}` > Param: `migrat_model?` => " +
            "This Model is not migrated to the database!"
          )
        end
      end
    end
  end
end
