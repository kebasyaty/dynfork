# Indexing collections.
module DynFork::Commons::Indexes
  extend self

  # This is a convenience method for creating a single index.
  # <br>
  # See: #create_indexes.
  #
  # Example:
  # ```
  # # Create one index without options…
  # ModelName.create_index(
  #   keys: {
  #     "a": 1,
  #     "b": -1,
  #   }
  # )
  # # or with options (snake_cased)
  # ModelName.create_index(
  #   keys: {
  #     "a": 1,
  #     "b": -1,
  #   },
  #   options: {
  #     unique: true,
  #   }
  # )
  # # and optionally specify the name.
  # ModelName.create_index(
  #   keys: {
  #     "a": 1,
  #     "b": -1,
  #   },
  #   options: {
  #     name: "index_name",
  #   }
  # )
  # ```
  #
  def create_index(
    keys,
    *,
    options = NamedTuple.new,
    commit_quorum : Int32 | String? = nil,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    if result : Mongo::Commands::CreateIndexes::Result? = collection.create_index(
         keys: keys,
         options: options,
         commit_quorum: commit_quorum,
         max_time_ms: max_time_ms,
         write_concern: write_concern,
         session: session,
       )
      if errmsg : String? = result.not_nil!.errmsg
        raise DynFork::Errors::Panic.new(
          "Model : `#{@@full_model_name}` > Method: `.create_index` => #{errmsg}"
        )
      end
    else
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Method: `.create_index` => " +
        "Index creation returned empty result!"
      )
    end
  end

  # Creates multiple indexes in the collection.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/createIndexes/" target="_blank">documentation</a>.
  #
  # Example:
  # ```
  # # Follow the same rules to create multiple indexes with a single method call.
  # ModelName.create_indexes([
  #   {
  #     keys: {a: 1},
  #   },
  #   {
  #     keys: {b: 2}, options: {expire_after_seconds: 3600},
  #   },
  # ])
  # ```
  #
  def create_indexes(
    models : Array,
    *,
    commit_quorum : Int32 | String? = nil,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    if result : Mongo::Commands::CreateIndexes::Result? = collection.create_indexes(
         models: models,
         commit_quorum: commit_quorum,
         max_time_ms: max_time_ms,
         write_concern: write_concern,
         session: session,
       )
      if errmsg : String? = result.not_nil!.errmsg
        raise DynFork::Errors::Panic.new(
          "Model : `#{@@full_model_name}` > Method: `.create_indexes` => #{errmsg}"
        )
      end
    else
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Method: `.create_indexes` => " +
        "Index creation returned empty result!"
      )
    end
  end

  # Drops a single index from the collection by the index name.
  # <br>
  # See: #drop_indexes.
  def drop_index(
    name : String,
    *,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    if collection.drop_index(
         name: name,
         max_time_ms: max_time_ms,
         write_concern: write_concern,
         session: session,
       ).nil?
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Method: `.drop_index` => " +
        "Index creation returned empty result!"
      )
    end
  end

  # Drops all indexes in the collection.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/dropIndexes/" target="_blank">documentation</a>.
  def drop_indexes(
    *,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    if collection.drop_indexes(
         max_time_ms: max_time_ms,
         write_concern: write_concern,
         session: session,
       ).nil?
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Method: `.drop_indexes` => " +
        "Index creation returned empty result!"
      )
    end
  end

  # Gets index information for all indexes in the collection.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/listIndexes/" target="_blank">documentation</a>.
  def list_indexes(session : Mongo::Session::ClientSession? = nil) : Mongo::Cursor?
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.list_indexes(session: session)
  end
end
