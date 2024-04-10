# ???
module DynFork::Commons::Indexes
  extend self

  # This is a convenience method for creating a single index.
  # <br>
  # See #create_indexes:
  # <br>
  # https://elbywan.github.io/cryomongo/Mongo/Collection.html#create_indexes%28models%3AArray%2C%2A%2Ccommit_quorum%3AInt32%7CString%3F%3Dnil%2Cmax_time_ms%3AInt64%3F%3Dnil%2Cwrite_concern%3AWriteConcern%3F%3Dnil%2Csession%3ASession%3A%3AClientSession%3F%3Dnil%29%3ACommands%3A%3ACreateIndexes%3A%3AResult%3F-instance-method
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
  def create_indexes(
    models : Array,
    commit_quorum : Int32 | String? = nil,
    max_time_ms : Int64? = nil,
    write_concern : WriteConcern? = nil,
    session : Session::ClientSession? = nil
  ) : Commands::CreateIndexes::Result?
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
end
