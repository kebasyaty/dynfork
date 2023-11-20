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
        model_state = Crymon::Migration::ModelState.from_bson(document)
        model_state.is_model_exists = false
        filter = {"collection_name": model_state.collection_name}
        update = {"$set": model_state}
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
        model_state = Crymon::Migration::ModelState.from_bson(document)
        unless model_state.is_model_exists?
          # Get the name of the collection associated with the Model.
          model_collection_name : String = model_state.collection_name
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
        next unless metadata[:is_add_doc]
        # Get database of application.
        database = Crymon::Globals.cache_mongo_client[Crymon::Globals.cache_database_name]
        # Get super collection - State of Models and dynamic field data.
        super_collection = database[Crymon::Globals.cache_super_collection_name]
        # Get collection name for current model.
        model_collection_name : String = metadata[:collection_name]
        # Get ModelState for current model.
        model_state, is_next = (
          filter = {"collection_name": model_collection_name}
          document = super_collection.find_one(filter)
          unless document.nil?
            # Get existing ModelState for the current model.
            m_state = Crymon::Migration::ModelState.from_bson(document)
            m_state.field_name_and_type_list = metadata[:field_name_and_type_list]
            m_state.is_model_exists = true
            # Update the state of the current Model.
            update = {"$set": m_state}
            super_collection.update_one(filter, update)
            {m_state, false}
          else
            # Create a new ModelState for current model.
            m_state = Crymon::Migration::ModelState.new(
              "collection_name": model_collection_name,
              "field_name_and_type_list": Hash(String, String).new,
              "is_model_exists": true,
            )
            super_collection.insert_one(m_state.to_bson)
            database.command(Mongo::Commands::Create, name: model_collection_name)
            {m_state, true}
          end
        )
        # If this is a new Model, move on to the next iteration.
        next if is_next
        # Get dynamic field data and add it to the current model's metadata.
        model_state.data_dynamic_fields.each do |key, value|
          metadata[:data_dynamic_fields][key] = value
        end
        # Get ignored field list of Model from cache.
        ignore_fields : Array(String) = metadata[:ignore_fields]
        # Review field changes in the current Model and (if necessary)
        # update documents in the appropriate Collection.
        # Some code...
      end
      # ------------------------------------------------------------------------
      # Delete data for non-existent Models from a
      # super collection and delete collections associated with those Models.
      self.napalm
    end
  end
end
