require "../../src/crymon"

# Auxiliary structures for testing.
module Helper
  # Model without variables and methods.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  @[Crymon::Meta(
    service_name: "ServiceName",
    db_query_docs_limit: 2000_u32
  )]
  struct FilledModel < Crymon::Model
    getter first_name = Crymon::Fields::TextField.new(
      "default": "Cat"
    )
    getter age = Crymon::Fields::U32Field.new(
      "default": 0,
      "is_ignored": true
    )
    getter birthday = Crymon::Fields::DateField.new(
      "default": "23.12.2023",
      "is_ignored": true
    )
  end

  # Auxiliary Model for tests.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct AuxiliaryModel < Crymon::Model
    getter name = Crymon::Fields::TextField.new
    getter slug = Crymon::Fields::SlugField.new
  end

  # Model with an incorrect slug source.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct SlugSourceInvalidModel < Crymon::Model
    getter name = Crymon::Fields::TextField.new
    getter slug = Crymon::Fields::SlugField.new(
      "slug_sources": ["first_name", "hash"]
    )
  end

  # Model without the required 'service_name' parameter for metadata.
  @[Crymon::Meta]
  struct NoParamServiceNameModel < Crymon::Model
    getter name = Crymon::Fields::TextField.new
    getter age = Crymon::Fields::U32Field.new
  end
end
