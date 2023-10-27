require "spec"
require "../src/crymon"

module Settings
  APP_NAME       = "AppName"
  UNIQUE_APP_KEY = "RT0839370A074kVh"
  SERVICE_NAME   = "ServiceName"
end

module Helper
  # Model without variables and methods.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME
  )]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME, unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME, db_query_docs_limit: 2000_u32,
    ignore_fields: ["age", "birthday"]
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

  # Model without the required 'app_name' parameter for metadata.
  @[Crymon::Metadata(
    unique_app_key: Settings::UNIQUE_APP_KEY,
    service_name: Settings::SERVICE_NAME
  )]
  struct NoParamAppNameModel < Crymon::Model
    getter name : String
    getter age : UInt32

    def initialize(
      @name : String,
      @age : UInt32
    ); end
  end

  # Model without the required 'unique_app_key' parameter for metadata.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME,
    service_name: Settings::SERVICE_NAME
  )]
  struct NoParamUniqueAppKeyModel < Crymon::Model
    getter name : String
    getter age : UInt32

    def initialize(
      @name : String,
      @age : UInt32
    ); end
  end

  # Model without the required 'service_name' parameter for metadata.
  @[Crymon::Metadata(
    app_name: Settings::APP_NAME,
    unique_app_key: Settings::UNIQUE_APP_KEY
  )]
  struct NoParamServiceMameModel < Crymon::Model
    getter name : String
    getter age : UInt32

    def initialize(
      @name : String,
      @age : UInt32
    ); end
  end
end
