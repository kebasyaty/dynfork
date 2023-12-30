module Crymon
  # ## Additional abstraction.
  # NOTE: How to use, see examples.
  # <br>
  # <br>
  # **Additional validation** - It is supposed to be use to additional validation of fields.
  # <br>
  # **Hooks** - Methods that are called at different stages when accessing the database.
  abstract struct AA
    # It is supposed to be use to additional validation of fields.
    # WARNING: The method is called automatically when checking or saving the Model.
    #
    # Example:
    # ```
    # @[Crymon::Meta(service_name: "Accounts")]
    # struct User < Crymon::Model
    #   getter username = Crymon::Fields::TextField.new
    #   getter password = Crymon::Fields::PasswordField.new
    #   getter confirm_password = Crymon::Fields::PasswordField.new(
    #     "is_ignored": true
    #   )
    #
    #   private def add_validation : Hash(String, String)
    #     error_map = Hash(String, String).new
    #     # Get clean data.
    #     password = @password.value
    #     confirm_password = @confirm_password.value
    #     # Fields validation.
    #     if password != confirm_password
    #       error_map["confirm_password"] = "Password confirmation does not match."
    #     end
    #     error_map
    #   end
    # end
    # ```
    #
    private def add_validation : Hash(String, String)
      # _**Format:** <"field_name", "Error message">_
      error_map = Hash(String, String).new
      error_map
    end

    # Called before a new document is created in the database.
    # <br>
    # WARNING: The method is called automatically.
    private def pre_create; end

    # Called after a new document has been created in the database.
    # <br>
    # WARNING: The method is called automatically.
    private def post_create; end

    # Called before updating an existing document in the database.
    # <br>
    # WARNING: The method is called automatically.
    private def pre_update; end

    # Called after an existing document in the database is updated.
    # <br>
    # WARNING: The method is called automatically.
    private def post_update; end

    # Called before deleting an existing document in the database.
    # <br>
    # WARNING: The method is called automatically.
    private def pre_delete; end

    # Called after an existing document in the database has been deleted.
    # <br>
    # WARNING: The method is called automatically.
    private def post_delete; end
  end
end
