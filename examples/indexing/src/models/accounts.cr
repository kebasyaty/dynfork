module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(unique: true)
    getter email = DynFork::Fields::EmailField.new(unique: true)
    getter birthday = DynFork::Fields::DateField.new

    def indexing
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        @@meta.not_nil![:collection_name]]
      #
      if result : Mongo::Commands::CreateIndexes::Result? = collection.create_index(
           keys: {
             "username": 1,
           },
           options: {
             unique: true,
             name:   "usernameIdx",
           }
         )
        if errmsg : String? = result.not_nil!.errmsg
          raise errmsg.not_nil!
        end
      else
        raise "Index creation returned empty result!"
      end
    end
  end
end
