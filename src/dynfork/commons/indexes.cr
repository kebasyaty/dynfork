# ???
module DynFork::Commons::Indexes
  extend self

  # This is a convenience method for creating a single index.
  # <br>
  # See: #create_indexes.
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

  # Drops a single index from the collection by the index name.
  # <br>
  # See: #drop_indexes.
  def drop_index(
    name : String,
    max_time_ms : Int64? = nil,
    write_concern : WriteConcern? = nil,
    session : Session::ClientSession? = nil
  ) : Commands::Common::BaseResult?
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
    write_concern : WriteConcern? = nil,
    session : Session::ClientSession? = nil
  ) : Commands::Common::BaseResult?
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
end
