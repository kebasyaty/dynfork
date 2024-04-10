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
    options = NamedTuple.new,
    commit_quorum : Int32 | String? = nil,
    max_time_ms : Int64? = nil,
    write_concern : WriteConcern? = nil,
    session : Session::ClientSession? = nil
  ) : Commands::CreateIndexes::Result?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.create_index(
      keys: keys,
      options: options,
      commit_quorum: commit_quorum,
      max_time_ms: max_time_ms,
      write_concern: write_concern,
      session: session,
    )
  end

  # Creates multiple indexes in the collection.
  # <br>
  # For more details, please check the official documentation:
  # https://docs.mongodb.com/manual/reference/command/createIndexes/
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
    commit_quorum : Int32 | String? = nil,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Mongo::Commands::CreateIndexes::Result?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.create_indexes(
      models: models,
      commit_quorum: commit_quorum,
      max_time_ms: max_time_ms,
      write_concern: write_concern,
      session: session,
    )
  end

  # Drops a single index from the collection by the index name.
  # <br>
  # See: #drop_indexes.
  def drop_index(
    name : String,
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Mongo::Commands::Common::BaseResult?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.drop_index(
      name: name,
      max_time_ms: max_time_ms,
      write_concern: write_concern,
      session: session,
    )
  end

  # Drops all indexes in the collection.
  # <br>
  # For more details, please check the official documentation:
  # <br>
  # https://docs.mongodb.com/manual/reference/command/dropIndexes/
  def drop_indexes(
    max_time_ms : Int64? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Mongo::Commands::Common::BaseResult?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.drop_indexes(
      max_time_ms: max_time_ms,
      write_concern: write_concern,
      session: session,
    )
  end

  # Gets index information for all indexes in the collection.
  # <br>
  # For more details, please check the official documentation:
  # https://docs.mongodb.com/manual/reference/command/listIndexes/
  def list_indexes(session : Mongo::Session::ClientSession? = nil) : Mongo::Cursor?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.list_indexes(session: session)
  end
end
