require "spec"
require "./testing_tools"
require "../src/crymon"

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

  # Auxiliary Model for tests.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct AuxiliaryModel < Crymon::Model
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
