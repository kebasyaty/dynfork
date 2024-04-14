# Queries like `find many`.
module DynFork::Commons::QMany
  extend self

  # Finds the documents matching the Model.
  # <br>
  # Converts documents into a array of Hash objects.
  # <br>
  # For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # <br>
  # For an overview of read operations, check the official <a href="https://docs.mongodb.com/manual/core/read-operations-introduction/" target="_blank">manual</a>.
  #
  # Example:
  # ```
  # arr = ModelName.find_many_to_hash_list({qty: {"$gt": 4}})
  # ```
  #
  def find_many_to_hash_list(
    filter = BSON.new,
    *,
    sort = nil,
    projection = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    skip : Int32? = nil,
    limit : Int32? = nil,
    batch_size : Int32? = nil,
    single_batch : Bool? = nil,
    comment : String? = nil,
    max_time_ms : Int64? = nil,
    read_concern : Mongo::ReadConcern? = nil,
    max = nil,
    min = nil,
    return_key : Bool? = nil,
    show_record_id : Bool? = nil,
    tailable : Bool? = nil,
    oplog_replay : Bool? = nil,
    no_cursor_timeout : Bool? = nil,
    await_data : Bool? = nil,
    allow_partial_results : Bool? = nil,
    allow_disk_use : Bool? = nil,
    collation : Mongo::Collation? = nil,
    read_preference : Mongo::ReadPreference? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Array(Hash(String, DynFork::Globals::ValueTypes))
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    hash_list = Array(Hash(String, DynFork::Globals::ValueTypes)).new
    cursor : Mongo::Cursor = collection.find(
      filter: filter,
      sort: sort,
      projection: projection,
      hint: hint,
      skip: skip,
      limit: limit || @@meta.not_nil![:db_query_docs_limit],
      batch_size: batch_size,
      single_batch: single_batch,
      comment: comment,
      max_time_ms: max_time_ms,
      read_concern: read_concern,
      max: max,
      min: min,
      return_key: return_key,
      show_record_id: show_record_id,
      tailable: tailable,
      oplog_replay: oplog_replay,
      no_cursor_timeout: no_cursor_timeout,
      await_data: await_data,
      allow_partial_results: allow_partial_results,
      allow_disk_use: allow_disk_use,
      collation: collation,
      read_preference: read_preference,
      session: session,
    )
    #
    field_name_type_group_list = @@meta.not_nil![:field_name_type_group_list]
    field_name_type_group_list_ptr = pointerof(field_name_type_group_list)
    cursor.each { |document|
      hash_list << self.document_to_hash(pointerof(document), field_name_type_group_list_ptr)
    }
    #
    hash_list
  end

  # Finds the documents matching the Model.
  # <br>
  # Converts documents to a json string.
  # <br>
  # For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # <br>
  # For an overview of read operations, check the official <a href="https://docs.mongodb.com/manual/core/read-operations-introduction/" target="_blank">manual</a>.
  #
  # Example:
  # ```
  # json_str = ModelName.find_many_to_json({qty: {"$gt": 4}})
  # ```
  #
  def find_many_to_json(
    filter = BSON.new,
    *,
    sort = nil,
    projection = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    skip : Int32? = nil,
    limit : Int32? = nil,
    batch_size : Int32? = nil,
    single_batch : Bool? = nil,
    comment : String? = nil,
    max_time_ms : Int64? = nil,
    read_concern : Mongo::ReadConcern? = nil,
    max = nil,
    min = nil,
    return_key : Bool? = nil,
    show_record_id : Bool? = nil,
    tailable : Bool? = nil,
    oplog_replay : Bool? = nil,
    no_cursor_timeout : Bool? = nil,
    await_data : Bool? = nil,
    allow_partial_results : Bool? = nil,
    allow_disk_use : Bool? = nil,
    collation : Mongo::Collation? = nil,
    read_preference : Mongo::ReadPreference? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : String
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    #
    json : String = "["
    cursor : Mongo::Cursor = collection.find(
      filter: filter,
      sort: sort,
      projection: projection,
      hint: hint,
      skip: skip,
      limit: limit || @@meta.not_nil![:db_query_docs_limit],
      batch_size: batch_size,
      single_batch: single_batch,
      comment: comment,
      max_time_ms: max_time_ms,
      read_concern: read_concern,
      max: max,
      min: min,
      return_key: return_key,
      show_record_id: show_record_id,
      tailable: tailable,
      oplog_replay: oplog_replay,
      no_cursor_timeout: no_cursor_timeout,
      await_data: await_data,
      allow_partial_results: allow_partial_results,
      allow_disk_use: allow_disk_use,
      collation: collation,
      read_preference: read_preference,
      session: session,
    )
    #
    field_name_type_group_list = @@meta.not_nil![:field_name_type_group_list]
    field_name_type_group_list_ptr = pointerof(field_name_type_group_list)
    cursor.each { |document|
      json += (self.document_to_hash(pointerof(document), field_name_type_group_list_ptr)).to_json
    }
    #
    if json.size > 1
      json += "]"
      return json
    end
    #
    ""
  end
end
