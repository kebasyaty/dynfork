module DynFork
  # Additional abstraction.
  # <br>
  # <br>
  # **Additional validation** - It is supposed to be use to additional validation of fields.
  # <br>
  # **Indexing** - XXX.
  # <br>
  # **Hooks** - Methods that are called at different stages when accessing the database.
  abstract struct AA
    # It is supposed to be use to additional validation of fields.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/additional_validation" target="_blank">example></a>.
    # WARNING: The method is called automatically when checking or saving the Model.
    #
    # Example:
    # ```
    # @[DynFork::Meta(service_name: "Accounts")]
    # struct User < DynFork::Model
    #   getter username = DynFork::Fields::TextField.new
    #   getter password = DynFork::Fields::PasswordField.new
    #   getter confirm_password = DynFork::Fields::PasswordField.new(
    #     "ignored": true
    #   )
    #
    #   private def add_validation : Hash(String, String)
    #     error_map = Hash(String, String).new
    #     # Get clean data.
    #     password : String? = @password.value?
    #     confirm_password : String? = @confirm_password.value?
    #     # Fields validation.
    #     if password != confirm_password
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

    # For set up and start indexing.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/indexing" target="_blank">example></a>.
    # WARNING: The method is called automatically.
    #
    # Example:
    # ```
    # @[DynFork::Meta(service_name: "Accounts")]
    # struct User < DynFork::Model
    #   getter username = DynFork::Fields::TextField.new
    #   getter email = DynFork::Fields::EmailField.new
    #
    #   def indexing
    #     # Get collection for current model.
    #     collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
    #       @@meta.not_nil![:collection_name]]
    #     #
    #     collection.create_index(
    #       keys: {
    #         "username": 1,
    #       },
    #       options: {
    #         unique: true,
    #         name:   "usernameIdx",
    #       }
    #     )
    #   end
    # end
    # ```
    #
    def self.indexing; end

    # Called before a new document is created in the database.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    # WARNING: The method is called automatically.
    def pre_create; end

    # Called after a new document has been created in the database.
    # WARNING: The method is called automatically.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    def post_create; end

    # Called before updating an existing document in the database.
    # WARNING: The method is called automatically.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    def pre_update; end

    # Called after an existing document in the database is updated.
    # WARNING: The method is called automatically.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    def post_update; end

    # Called before deleting an existing document in the database.
    # WARNING: The method is called automatically.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    def pre_delete; end

    # Called after an existing document in the database has been deleted.
    # WARNING: The method is called automatically.
    # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/hooks" target="_blank">example></a>.
    def post_delete; end
  end
end
