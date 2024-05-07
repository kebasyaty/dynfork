# Requests like `find one`.
module DynFork::QCommons::One
  extend self

  # Finds the document and converts it to a Model instance.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  #
  # Example:
  # ```
  # model_name : ModelName? = ModelName.find_one_to_instance({_id: id})
  # ```
  #
  def find_one_to_instance(
    filter = BSON.new,
    *,
    sort = nil,
    projection = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    skip : Int32? = nil,
    comment : String? = nil,
    max_time_ms : Int64? = nil,
    read_concern : Mongo::ReadConcern? = nil,
    max = nil,
    min = nil,
    return_key : Bool? = nil,
    show_record_id : Bool? = nil,
    oplog_replay : Bool? = nil,
    no_cursor_timeout : Bool? = nil,
    allow_partial_results : Bool? = nil,
    collation : Mongo::Collation? = nil,
    read_preference : Mongo::ReadPreference? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : self?
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
    if doc : BSON? = collection.find_one(
         filter: filter,
         sort: sort,
         projection: projection,
         hint: hint,
         skip: skip,
         comment: comment,
         max_time_ms: max_time_ms,
         read_concern: read_concern,
         max: max,
         min: min,
         return_key: return_key,
         show_record_id: show_record_id,
         oplog_replay: oplog_replay,
         no_cursor_timeout: no_cursor_timeout,
         allow_partial_results: allow_partial_results,
         collation: collation,
         read_preference: read_preference,
         session: session,
       )
      instance = self.new
      instance.refrash_fields pointerof(doc)
      return instance
    end
    #
    nil
  end

  # Find the document and convert it to a Hash object.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  #
  # Example:
  # ```
  # doc_hash : Hash(String, DynFork::Globals::FieldValueTypes)? = ModelName.find_one_to_hash({_id: id})
  # ```
  #
  def find_one_to_hash(
    filter = BSON.new,
    *,
    sort = nil,
    projection = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    skip : Int32? = nil,
    comment : String? = nil,
    max_time_ms : Int64? = nil,
    read_concern : Mongo::ReadConcern? = nil,
    max = nil,
    min = nil,
    return_key : Bool? = nil,
    show_record_id : Bool? = nil,
    oplog_replay : Bool? = nil,
    no_cursor_timeout : Bool? = nil,
    allow_partial_results : Bool? = nil,
    collation : Mongo::Collation? = nil,
    read_preference : Mongo::ReadPreference? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : Hash(String, DynFork::Globals::FieldValueTypes)?
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
    if doc : BSON? = collection.find_one(
         filter: filter,
         sort: sort,
         projection: projection,
         hint: hint,
         skip: skip,
         comment: comment,
         max_time_ms: max_time_ms,
         read_concern: read_concern,
         max: max,
         min: min,
         return_key: return_key,
         show_record_id: show_record_id,
         oplog_replay: oplog_replay,
         no_cursor_timeout: no_cursor_timeout,
         allow_partial_results: allow_partial_results,
         collation: collation,
         read_preference: read_preference,
         session: session,
       )
      doc_bson : BSON = doc.not_nil!
      field_name_params_list = @@meta.not_nil![:field_name_params_list]
      field_name_params_list_ptr = pointerof(field_name_params_list)
      doc_hash = self.document_to_hash(pointerof(doc_bson), field_name_params_list_ptr)
      return doc_hash
    end
    #
    nil
  end

  # Finds the document and converts it to a json string.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/find/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  #
  # Example:
  # ```
  # json_str : String? = ModelName.find_one_to_json({_id: id})
  # ```
  #
  def find_one_to_json(
    filter = BSON.new,
    *,
    sort = nil,
    projection = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    skip : Int32? = nil,
    comment : String? = nil,
    max_time_ms : Int64? = nil,
    read_concern : Mongo::ReadConcern? = nil,
    max = nil,
    min = nil,
    return_key : Bool? = nil,
    show_record_id : Bool? = nil,
    oplog_replay : Bool? = nil,
    no_cursor_timeout : Bool? = nil,
    allow_partial_results : Bool? = nil,
    collation : Mongo::Collation? = nil,
    read_preference : Mongo::ReadPreference? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : String
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
    if doc : BSON? = collection.find_one(
         filter: filter,
         sort: sort,
         projection: projection,
         hint: hint,
         skip: skip,
         comment: comment,
         max_time_ms: max_time_ms,
         read_concern: read_concern,
         max: max,
         min: min,
         return_key: return_key,
         show_record_id: show_record_id,
         oplog_replay: oplog_replay,
         no_cursor_timeout: no_cursor_timeout,
         allow_partial_results: allow_partial_results,
         collation: collation,
         read_preference: read_preference,
         session: session,
       )
      instance = self.new
      instance.refrash_fields pointerof(doc)
      json : String = instance.to_json
      return json
    end
    #
    ""
  end

  # Deletes one document.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/delete/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  def delete_one(
    filter,
    *,
    collation : Mongo::Collation? = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
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
    collection.delete_one(
      filter: filter,
      collation: collation,
      hint: hint,
      ordered: ordered,
      write_concern: write_concern,
      session: session,
    )
  end

  # Finds a single document and deletes it, returning the original.
  # The document to return may be nil.
  # NOTE: For more details, please check the official <a href="https://docs.mongodb.com/manual/reference/command/findAndModify/" target="_blank">documentation</a>.
  # NOTE: For more details, please check the cryomongo <a href="https://elbywan.github.io/cryomongo/Mongo/Collection.html" target="_blank">documentation</a>.
  #
  # Example:
  # ```
  # model_name : ModelName? = ModelName.find_one_and_delete({_id: id})
  # ```
  #
  def find_one_and_delete(
    filter,
    *,
    sort = nil,
    fields = nil,
    bypass_document_validation : Bool? = nil,
    write_concern : Mongo::WriteConcern? = nil,
    collation : Mongo::Collation? = nil,
    hint : String | Hash | NamedTuple | Nil = nil,
    max_time_ms : Int64? = nil,
    session : Mongo::Session::ClientSession? = nil
  ) : self?
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
    if doc : BSON? = collection.find_one_and_delete(
         filter: filter,
         sort: sort,
         fields: fields,
         bypass_document_validation: bypass_document_validation,
         write_concern: write_concern,
         collation: collation,
         hint: hint,
         max_time_ms: max_time_ms,
         session: session,
       )
      instance = self.new
      instance.refrash_fields pointerof(doc)
      return instance
    end
    #
    nil
  end
end
