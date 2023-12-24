require "bson"

# Migrations are Crymon way of
# propagating changes you make to
# your models (adding a field, deleting a collection, etc.) into
# your database schema.
module Crymon::Migration
  # To control the state of Models in the super collection.
  struct ModelState
    include BSON::Serializable

    getter collection_name : String
    property field_name_and_type_list : Hash(String, String)
    property data_dynamic_fields : Hash(String, String)
    property? is_model_exists : Bool

    def initialize(
      @collection_name : String,
      @field_name_and_type_list : Hash(String, String),
      @is_model_exists : Bool = false
    )
      @data_dynamic_fields = Hash(String, String).new
    end
  end

  # Monitoring and update the database state for the application.
  struct Monitor
    getter model_key_list : Array(String)

    def initialize(
      app_name : String,
      unique_app_key : String,
      mongo_uri : String,
      @model_key_list : Array(String),
      database_name : String = ""
    )
      # Update global storage state.
      Crymon::Globals.cache_app_name = app_name
      Crymon::Globals.cache_unique_app_key = unique_app_key
      Crymon::Globals.cache_mongo_client = Mongo::Client.new mongo_uri
      unless database_name.empty?
        Crymon::Globals.cache_database_name = database_name
      end
      Crymon::Globals::ValidationCacheSettings.validation
    end

    # Update the state of Models in the super collection.
    private def refresh
      # Get super collection - State of Models and dynamic field data.
      super_collection = Crymon::Globals.cache_mongo_client[
        Crymon::Globals.cache_database_name][
        Crymon::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor : Mongo::Cursor = super_collection.find
      # Reset Models state information.
      cursor.each { |document|
        filter = {"collection_name": document["collection_name"]}
        update = {"$set": {"is_model_exists": false}}
        super_collection.update_one(filter, update)
      }
    end

    # Delete data for non-existent Models from a
    # super collection and delete collections associated with those Models.
    private def napalm
      # Get database of application.
      database = Crymon::Globals.cache_mongo_client[Crymon::Globals.cache_database_name]
      # Get super collection - State of Models and dynamic field data.
      super_collection = database[Crymon::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor : Mongo::Cursor = super_collection.find
      # Delete data for non-existent Models.
      cursor.each { |document|
        unless document["is_model_exists"]
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
    def migrat
      # Update the state of Models in the super collection.
      self.refresh
      # ------------------------------------------------------------------------
      # Enumeration of keys for Model migration.
      @model_key_list.each do |model_key|
        # Get metadata of Model from cache.
        metadata : Crymon::Globals::CacheMetaDataType = Crymon::Globals.cache_metadata[model_key]
        # If the Model parameter is_add_doc is false, skip the iteration.
        next unless metadata[:is_saving_docs]
        # Get database of application.
        database : Mongo::Database = Crymon::Globals.cache_mongo_client[
          Crymon::Globals.cache_database_name]
        # Get super collection - State of Models and dynamic fields data.
        super_collection : Mongo::Collection = database[
          Crymon::Globals.cache_super_collection_name]
        # Get ModelState for current Model.
        model_state, is_next = (
          filter = {"collection_name": metadata[:collection_name]}
          document = super_collection.find_one(filter)
          unless document.nil?
            # Get existing ModelState for the current Model.
            m_state = Crymon::Migration::ModelState.from_bson(document)
            m_state.is_model_exists = true
            {m_state, false}
          else
            # Create a new ModelState for current Model.
            m_state = Crymon::Migration::ModelState.new(
              "collection_name": metadata[:collection_name],
              "field_name_and_type_list": metadata[:field_name_and_type_list],
              "is_model_exists": true,
            )
            super_collection.insert_one(m_state.to_bson)
            database.command(Mongo::Commands::Create, name: m_state.collection_name)
            {m_state, true}
          end
        )
        # If this is a new Model, move on to the next iteration.
        next if is_next
        # Get a list of ignored Model fields from the cache.
        ignore_fields : Array(String) = metadata[:ignore_fields]
        # Review field changes in the current Model and (if necessary)
        # update documents in the appropriate Collection.
        if model_state.field_name_and_type_list != metadata[:field_name_and_type_list]
          # Get a list of default values.
          default_value_list = metadata[:default_value_list]
          # List of previous field names.
          old_field_name_list : Array(String) = model_state.field_name_and_type_list.keys
          # Get a list of missing fields.
          missing_fields : Array(String) = old_field_name_list -
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
          cursor.each { |document|
            # Create a new document for the updated state.
            freshed_document = BSON.new({"_id": document["_id"]})
            # Create a new document without the deleted fields.
            old_field_name_list.each do |field_name|
              unless missing_fields.includes?(field_name)
                freshed_document[field_name] = document[field_name]
              end
            end
            # Add new fields with default value or
            # update existing fields whose field type has changed.
            new_fields.each do |field_name|
              document[field_name] = (
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
        # ???
        if true
          # ...
        end
        # ----------------------------------------------------------------------
        # Get dynamic field data and add it to the current Model metadata.
        model_state.data_dynamic_fields.each do |field_name, data|
          metadata[:data_dynamic_fields][field_name] = data
        end
        # Update list.
        model_state.field_name_and_type_list = metadata[:field_name_and_type_list]
        # Update the state of the current Model.
        filter = {"collection_name": model_state.collection_name}
        update = {"$set": model_state}
        super_collection.update_one(filter, update)
      end
      # ------------------------------------------------------------------------
      # Delete data for non-existent Models from a
      # super collection and delete collections associated with those Models.
      self.napalm
    end
  end
end
