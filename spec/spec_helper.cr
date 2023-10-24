require "spec"
require "../src/crymon"

APP_NAME        = "AppName"
UNIQUE_APP_KEY  = "123"
SERVICE_NAME    = "ServiceName"
DATABASE_NAME   = "DatabaseName"
COLLECTION_NAME = "CollectionName"

module Helper
  # Model without variables and methods.
  @[Crymon::Metadata(
    app_name: APP_NAME, unique_app_key: UNIQUE_APP_KEY,
    service_name: SERVICE_NAME, database_name: DATABASE_NAME,
    collection_name: COLLECTION_NAME
  )]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  struct FilledModel < Crymon::Model
    getter name : String
    getter age : UInt32
    getter birthday : Helper::Birthday

    def initialize(
      @name : String,
      @age : UInt32,
      @birthday = Helper::Birthday.new
    ); end
  end

  # For testing: Helper::Birthday to Birthday in Model.
  struct Birthday
    getter date : String = "1990-11-7"
  end
end
