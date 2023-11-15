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
    getter field_name_and_type_list : Hash(String, String)
    property data_dynamic_fields : Hash(String, Crymon::Globals::DataDynamicTypes)
    property? is_updated_state : Bool

    def initialize(
      @collection_name : String,
      @field_name_and_type_list : Hash(String, String),
      @is_updated_state : Bool = false
    )
      @data_dynamic_fields = Hash(String, Crymon::Globals::DataDynamicTypes).new
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
      # Run the migration process.
      # WARNING: It is not safe to change the order of methods.
      self.refresh
      self.migrat
      self.napalm
    end

    # Update the state of Models in the super collection.
    private def refresh
      # Get super collection - State of Models and dynamic field data.
      super_collection = Crymon::Globals.cache_mongo_client[
        Crymon::Globals.cache_database_name][
        Crymon::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor = super_collection.find
      # Reset Models state information.
      cursor.each { |document|
        model_state = Crymon::Migration::ModelState.from_bson(document)
        model_state.is_updated_state = false
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
      cursor = super_collection.find
      # Delete data for non-existent Models.
      cursor.each { |document|
        model_state = Crymon::Migration::ModelState.from_bson(document)
        unless model_state.is_updated_state?
          collection_name = model_state.collection_name
          # Delete data for non-existent Model.
          super_collection.delete_one({"collection_name": collection_name})
          # Delete collection associated with non-existent Model.
          database.command(Mongo::Commands::Drop, name: collection_name)
        end
      }
    end

    # 1) Add models states to the super collection if missing.
    # <br>
    # 2) Check the changes in the models and (if necessary) apply to the database.
    private def migrat
      # ...
    end
  end
end
