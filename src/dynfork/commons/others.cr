# ???
module DynFork::Commons::Others
  extend self

  # Runs an aggregation framework pipeline.
  # <br>
  # For more details, please check the official MongoDB documentation:
  # <br>
  # https://docs.mongodb.com/manual/reference/command/aggregate/
  def aggregate(
    pipeline : Array, *,
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
      pipeline,
      allow_disk_use,
      batch_size,
      max_time_ms,
      bypass_document_validation,
      collation,
      hint,
      comment,
      read_concern,
      write_concern,
      read_preference,
      session,
    )
  end

  # Count the number of documents in a collection that match the given filter.
  # <br>
  # Note that an empty filter will force a scan of the entire collection.
  # <br> 
  # For a fast count of the total documents in a collection see **estimated_document_count**.
  def count_documents(
    filter = BSON.new,
    *,
    skip : Int32? = nil,
    limit : Int32? = nil,
    collation : Collation? = nil,
    hint : String | H? = nil,
    max_time_ms : Int64? = nil,
    read_preference : ReadPreference? = nil,
    session : Session::ClientSession? = nil,
  ) : Int32
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    collection.count_documents(
      filter,
      *,
      skip,
      limit,
      collation,
      hint,
      max_time_ms,
      read_preference,
      session,
    )
  end
end
