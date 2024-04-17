require "../../src/dynfork"

# Structures for testing.
module Spec::Data
  # Model without variables and methods.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct EmptyModel < DynFork::Model; end

  # Model with variables and methods.
  @[DynFork::Meta(
    service_name: "ServiceName",
    db_query_docs_limit: 2000,
    saving_docs?: false,
    updating_docs?: false,
    deleting_docs?: false,
  )]
  struct FilledModel < DynFork::Model
    getter first_name = DynFork::Fields::TextField.new(
      default: "Cat"
    )
    getter age = DynFork::Fields::I64Field.new(
      min: 0,
      default: 0,
      ignored: true
    )
    getter birthday = DynFork::Fields::DateField.new(
      default: "23.12.2023",
      ignored: true
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
      slug_sources: ["first_name", "hash"]
    )
  end

  # Model without the required 'service_name' parameter for metadata.
  @[DynFork::Meta]
  struct NoParamServiceNameModel < DynFork::Model
    getter name = DynFork::Fields::TextField.new
    getter age = DynFork::Fields::I64Field.new(min: 0)
  end

  # Test removing a document from a collection.
  @[DynFork::Meta(service_name: "Accounts")]
  struct DeleteModel < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
  end

  # For the test - Update password.
  @[DynFork::Meta(service_name: "Accounts")]
  struct UpdatePassword < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
  end

  @[DynFork::Meta(service_name: "Accounts")]
  struct DynFieldsModel < DynFork::Model
    # test
    getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new
    # i64
    getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new
    # f64
    getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new
  end

  # ???
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteSettings",
    create_doc?: false,
    delete_doc?: false,
  )]
  struct SiteSettings < DynFork::Model
    getter logo = DynFork::Fields::ImageField.new(
      default: "assets/media/default/no_photo.jpeg",
      thumbnails: [{"xs", 40}, {"sm", 80}, {"md", 120}, {"lg", 160}]
    )
    getter brand = DynFork::Fields::TextField.new
    getter slogan = DynFork::Fields::TextField.new
    getter meta_title = DynFork::Fields::TextField.new
    getter meta_description = DynFork::Fields::TextField.new
    getter contact_email = DynFork::Fields::EmailField.new
  end

  # For preliminary testing of additional abstractions.
  @[DynFork::Meta(service_name: "Accounts")]
  struct AAModel < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
    getter confirm_password = DynFork::Fields::PasswordField.new(
      ignored: true
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
