module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter email = DynFork::Fields::EmailField.new
    getter birthday = DynFork::Fields::DateField.new

    def indexing
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        @@meta.not_nil![:collection_name]]
      #
      collection.create_index(
        keys: {
          "username": 1,
        },
        options: {
          unique: true,
          name:   "usernameIdx",
        }
      )
    end
  end
end
