require "../../src/dynfork"

# Structures for testing.
module Spec::Data
  # Model without variables and methods.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct EmptyModel < DynFork::Model; end

  # Model with variables and methods.
  @[DynFork::Meta(
    service_name: "ServiceName",
    db_query_docs_limit: 2000_u32,
    saving_docs?: false,
    updating_docs?: false,
    deleting_docs?: false,
  )]
  struct FilledModel < DynFork::Model
    getter first_name = DynFork::Fields::TextField.new(
      "default": "Cat"
    )
    getter age = DynFork::Fields::I64Field.new(
      "min": 0,
      "default": 0,
      "ignored": true
    )
    getter birthday = DynFork::Fields::DateField.new(
      "default": "23.12.2023",
      "ignored": true
    )
  end

  # Auxiliary Model for tests.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct AuxiliaryModel < DynFork::Model
    getter name = DynFork::Fields::TextField.new
    getter slug = DynFork::Fields::SlugField.new
  end

  # Model with an incorrect slug source.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct SlugSourceInvalidModel < DynFork::Model
    getter name = DynFork::Fields::TextField.new
    getter slug = DynFork::Fields::SlugField.new(
      "slug_sources": ["first_name", "hash"]
    )
  end

  # Model without the required 'service_name' parameter for metadata.
  @[DynFork::Meta]
  struct NoParamServiceNameModel < DynFork::Model
    getter name = DynFork::Fields::TextField.new
    getter age = DynFork::Fields::I64Field.new(
      "min": 0
    )
  end

  # For preliminary testing of additional abstractions.
  @[DynFork::Meta(service_name: "Accounts")]
  struct AAModel < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
    getter confirm_password = DynFork::Fields::PasswordField.new(
      "ignored": true
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
