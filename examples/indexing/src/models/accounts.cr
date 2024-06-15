module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(unique: true)
    getter email = DynFork::Fields::EmailField.new(unique: true)
    getter birthday = DynFork::Fields::DateField.new

    def self.indexing
      self.create_index(
        keys: {
          "username": 1,
        },
        options: {
          name: "usernameIdx",
        }
      )
    end
  end
end
