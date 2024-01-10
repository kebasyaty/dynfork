require "../../src/crymon"

# Structures for testing.
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
    getter age = Crymon::Fields::I32Field.new(
      "min": 0,
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
    getter age = Crymon::Fields::I32Field.new(
      "min": 0
    )
  end

  # For preliminary testing of additional abstractions.
  @[Crymon::Meta(service_name: "Accounts")]
  struct AAModel < Crymon::Model
    getter username = Crymon::Fields::TextField.new
    getter password = Crymon::Fields::PasswordField.new
    getter confirm_password = Crymon::Fields::PasswordField.new(
      "is_ignored": true
    )

    private def add_validation : Hash(String, String)
      error_map = Hash(String, String).new
      # Get clean data.
      password = @password.value
      confirm_password = @confirm_password.value
      # Fields validation.
      if password != confirm_password
        error_map["confirm_password"] = "Password confirmation does not match."
      end
      error_map
    end

    private def pre_create
      pust "!!!=Pre Create=!!!"
    end

    private def post_create
      pust "!!!=Post Create=!!!"
    end

    private def pre_update
      pust "!!!=Pre Update=!!!"
    end

    private def post_update
      pust "!!!=Post Update=!!!"
    end

    private def pre_delete
      pust "!!!=Pre Delete=!!!"
    end

    private def post_delete
      pust "!!!=Post Delete=!!!"
    end
  end
end
