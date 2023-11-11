require "spec"
require "../src/crymon"

# Global project settings.
Crymon::Globals.store_settings[:app_name] = "AppName"
Crymon::Globals.store_settings[:unique_app_key] = "RT0839370A074kVh"
Crymon::Globals.store_settings[:database_name] = "DatabaseName360"

module Helper
  # Model without variables and methods.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  @[Crymon::Meta(
    service_name: "ServiceName",
    db_query_docs_limit: 2000_u32,
    ignore_fields: ["age", "birthday"]
  )]
  struct FilledModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new("default": "Cat")
    getter age = Crymon::Fields::U32Field.new("default": 0)
    getter birthday = Crymon::Fields::DateField.new("default": "0000-00-00")
  end

  # Model with a predefined database name.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct ParamDBNameModel < Crymon::Model
    getter name = Crymon::Fields::TextField.new
  end

  # Model without the required 'service_name' parameter for metadata.
  @[Crymon::Meta]
  struct NoParamServiceNameModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end

  # Incorrect field names in the ignored list.
  @[Crymon::Meta(
    service_name: "ServiceName",
    db_query_docs_limit: 2000_u32,
    ignore_fields: ["age", "birthday"]
  )]
  struct IncorrectIgnoredListModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end
end
