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
    getter field_list : Array(String)
    getter field_types : Hash(String, String)
    property is_updated_state : Bool = false
    getter is_model : Bool = true

    def initialize(
      @collection_name : String,
      @field_list : Array(String),
      @field_types : Hash(String, Crymon::Globals::FieldTypes)
    )
    end
  end

  # Monitoring and update the database state for the application.
  struct Monitor
    def initialize(
      app_name : String,
      unique_app_key : String,
      mongo_uri : String,
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

    # 1) Add a super collection to the database if it is missing.
    # <br>
    # 2) Update the state of Models in the super collection.
    def refresh
      # Get super collection.
      super_collection = Crymon::Globals.cache_mongo_client[
        Crymon::Globals.cache_database_name][
        Crymon::Globals.cache_super_collection_name]
      # Fetch a Cursor pointing to the super collection.
      cursor = super_collection.find({is_model: true})
      # Reset Models state information.
      cursor.each { |document|
        model_state = ModelState.from_bson(document)
        model_state.is_updated_state = false
        filter = {"collection_name": model_state.collection_name}
        update = {"$set": model_state}
        super_collection.update_one(filter, update)
      }
    end
  end
end
