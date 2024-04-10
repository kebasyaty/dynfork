# General purpose query methods.
module DynFork::Commons::QGeneral
  extend self

  # Runs an aggregation framework pipeline.
  # <br>
  # For more details, please check the official MongoDB documentation:
  # <br>
  # https://docs.mongodb.com/manual/reference/command/aggregate/
  def aggregate(
    pipeline : Array,
    allow_disk_use : Bool? = nil,
    batch_size : Int32? = nil,
    max_time_ms : Int64? = nil,
    bypass_document_validation : Bool? = nil,
    collation : Collation? = nil,
    hint : String | H? = nil,
    comment : String? = nil,
    read_concern : ReadConcern? = nil,
    write_concern : WriteConcern? = nil,
    read_preference : ReadPreference? = nil,
    session : Session::ClientSession? = nil
  ) : Mongo::Cursor?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.aggregate(
      pipeline: pipeline,
      allow_disk_use: allow_disk_use,
      batch_size: batch_size,
      max_time_ms: max_time_ms,
      bypass_document_validation: bypass_document_validation,
      collation: collation,
      hint: hint,
      comment: comment,
      read_concern: read_concern,
      write_concern: write_concern,
      read_preference: read_preference,
      session: session,
    )
  end

  # Finds the distinct values for a specified field across a single collection.
  # <br>
  # NOTE: the results are backed by the "values" array in the distinct command's result document. This differs from aggregate and find, where results are backed by a cursor.
  # For more details, please check the official MongoDB documentation:
  # <br>
  # https://docs.mongodb.com/manual/reference/command/distinct/
  def distinct(key : String, *, filter = nil, read_concern : ReadConcern? = nil, collation : Collation? = nil, read_preference : ReadPreference? = nil, session : Session::ClientSession? = nil) : Array
    # ...
  end

  # Count the number of documents in a collection that match the given filter.
  # <br>
  # Note that an empty filter will force a scan of the entire collection.
  # <br>
  # For a fast count of the total documents in a collection see **estimated_document_count**.
  def count_documents(
    filter = BSON.new,
    skip : Int32? = nil,
    limit : Int32? = nil,
    collation : Collation? = nil,
    hint : String | H? = nil,
    max_time_ms : Int64? = nil,
    read_preference : ReadPreference? = nil,
    session : Session::ClientSession? = nil
  ) : Int32
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get document count.
    collection.count_documents(
      filter: filter,
      skip: skip,
      limit: limit,
      collation: collation,
      hint: hint,
      max_time_ms: max_time_ms,
      read_preference: read_preference,
      session: session,
    )
  end

  # Gets an estimate of the count of documents in a collection using collection metadata.
  # <br>
  # See the specification document:
  # <br>
  # https://github.com/mongodb/specifications/blob/master/source/crud/crud.rst#count-api-details
  def estimated_document_count(
    max_time_ms : Int64? = nil,
    read_preference : ReadPreference? = nil,
    session : Session::ClientSession? = nil
  ) : Int32
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get document count.
    collection.estimated_document_count(
      max_time_ms: max_time_ms,
      read_preference: read_preference,
      session: session,
    )
  end

  # The parent database.
  def database : Mongo::Database
    DynFork::Globals.cache_mongo_database
  end

  # The collection name.
  def name : CollectionKey
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get the collection name.
    collection.name
  end

  # Returns a variety of storage statistics for the collection.
  # <br>
  # For more details, please check the official MongoDB documentation:
  # <br>
  # https://docs.mongodb.com/manual/reference/command/collStats/
  def stats(
    scale : Int32? = nil,
    session : Session::ClientSession? = nil
  ) : BSON?
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get statistics.
    collection.stats(
      scale: scale,
      session: session,
    )
  end
end
