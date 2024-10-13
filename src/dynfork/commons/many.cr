# Queries like `find many`.
module DynFork::QCommons::Many
  extend self

  # Finds the documents matching the Model.
  # <br>
  # Converts documents into a array of Hash objects.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # NOTE: For an overview of read operations, check the official <a href="https://docs.mongodb.com/manual/core/read-operations-introduction/" target="_blank">manual</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
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
    hint : (String | Hash | NamedTuple)? = nil,
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
  ) : Array(Hash(String, DynFork::Globals::FieldValueTypes))?
    #
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
    hash_list = Array(Hash(String, DynFork::Globals::FieldValueTypes)).new
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
    field_name_params_list = @@meta.not_nil![:field_name_params_list]
    cursor.each do |doc|
      hash_list << self.document_to_hash(doc, field_name_params_list)
    end
    #
    return hash_list unless hash_list.empty?
  end

  # Finds the documents matching the Model.
  # <br>
  # Converts documents to a json string.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # NOTE: For an overview of read operations, check the official <a href="https://docs.mongodb.com/manual/core/read-operations-introduction/" target="_blank">manual</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
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
    hint : (String | Hash | NamedTuple)? = nil,
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
  ) : String?
    #
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
    hash_arr = Array(Hash(String, DynFork::Globals::FieldValueTypes)).new
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
    field_name_params_list = @@meta.not_nil![:field_name_params_list]
    cursor.each do |doc|
      hash_arr << self.document_to_hash(doc, field_name_params_list)
    end
    #
    return (hash_arr.to_json) unless hash_arr.empty?
  end

  # Deletes multiple documents.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/delete/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  def delete_many(
    filter,
    *,
    collation : Mongo::Collation? = nil,
    hint : (String | Hash | NamedTuple)? = nil,
    ordered : Bool? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Mongo::Commands::Common::DeleteResult?
    #
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
    collection.delete_many(
      filter: filter,
      collation: collation,
      hint: hint,
      ordered: ordered,
      write_concern: write_concern,
      session: session,
    )
  end
end
