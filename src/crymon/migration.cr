# Migrations are Crymon way of
# propagating changes you make to
# your models (adding a field, deleting a collection, etc.) into
# your database schema.
module Crymon::Migration
  # Monitoring and updating the database of application.
  struct Monitor
    getter app_name : String
    getter unique_app_key : String
    getter database_name : String
    getter mongo_uri : String

    def initialize(
      @app_name : String,
      @unique_app_key : String,
      @mongo_uri : String,
      @database_name : String = ""
    )
    end

    # Update global storage state.
    def set_global_data
      Crymon::Globals.cache_app_name = @app_name
      Crymon::Globals.cache_unique_app_key = @unique_app_key
      Crymon::Globals.cache_mongo_client = Mongo::Client.new(@mongo_uri)
      unless @database_name.empty?
        Crymon::Globals.cache_database_name = @database_name
      end
      Crymon::Globals::ValidationCacheSettings.validation
    end
  end
end
