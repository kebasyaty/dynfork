require "spec"
require "../src/crymon"

module Settings
  APP_NAME       = "AppName"
  UNIQUE_APP_KEY = "123"
  SERVICE_NAME   = "ServiceName"
  DATABASE_NAME  = "DatabaseName"
end

module Helper
  # Model without variables and methods.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, database_name: Settings::DATABASE_NAME
  )]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, database_name: Settings::DATABASE_NAME,
    db_query_docs_limit: 2000_u32, ignore_fields: ["age", "birthday"]
  )]
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
