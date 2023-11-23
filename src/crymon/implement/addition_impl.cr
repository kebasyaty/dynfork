require "./hooks_impl"

module Crymon::Implement
  # A set of tools for additional actions.
  abstract struct Addition < Crymon::Implement::Hooks
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
    #     if !password.nil? && password != confirm_password
    #       error_map["confirm_password"] = "Password confirmation does not match."
    #     end
    #     error_map
    #   end
    # end
    # ```
    #
    def add_validation : Hash(String, String)
      # _**Format:** <"field_name", "Error message">_
      error_map = Hash(String, String).new
      error_map
    end
  end
end
