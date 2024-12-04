module Models::Accounts
  @[DynFork::Meta(
    service_name: "Accounts",
    deleting_docs?: false,
  )]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(
      label: "Username",
      placeholder: "Enter your username",
      maxlength: 150,
      minlength: 1,
      regex: "^[a-zA-Z0-9_@.+]+$",
      regex_err_msg: I18n.t(
        "allowed_chars.interpolation",
        chars: "a-z A-Z 0-9 _ @ . +"
      ),
      required: true,
      unique: true,
    )
    getter email = DynFork::Fields::EmailField.new(
      label: "E-mail",
      placeholder: "Enter your email",
      maxlength: 320,
      required: true,
      unique: true,
    )
    getter birthday = DynFork::Fields::DateField.new(
      label: "Birthday",
    )
    getter password = DynFork::Fields::PasswordField.new(
      label: "Password",
    )
    # Do not save the value of this field to the database.
    # This field is for verification purposes only (ignored = true).
    getter confirm_password = DynFork::Fields::PasswordField.new(
      label: "Confirm password",
      ignored: true,
    )
    getter is_active = DynFork::Fields::BoolField.new(
      label: "is active?",
      default: true,
    )
    getter slug = DynFork::Fields::SlugField.new(
      label: "Slug",
      slug_sources: ["hash", "username"],
      hide: true,
    )

    private def add_validation : Hash(String, String)
      error_map = Hash(String, String).new
      # Get clean data.
      password : String? = @password.value?
      confirm_password : String? = @confirm_password.value?
      # Fields validation.
      if password != confirm_password
        error_map["confirm_password"] = I18n.t(:pass_does_not_match)
      end
      error_map
    end
  end
end
