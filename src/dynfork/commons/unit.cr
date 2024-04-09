# Units Management.
# NOTE: Management for `choices` parameter in dynamic field types.
module DynFork::Commons::UnitsManagement
  extend self

  # For insert or delete units.
  # NOTE: Management for `choices` parameter in dynamic field types.
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  #
  # unit = DynFork::Globals::DynUnit.new(
  #   field: "field_name",
  #   title: "Title",
  #   value: "value", # String | Int64 | Float64
  #   delete: false   # default is the same as false
  # )
  #
  # User.unit_manager unit
  # ```
  #
  def unit_manager(unit : DynFork::Globals::Unit)
    # Unit validation.
    if unit.field.empty?
      self.error_empty_field("field")
    end
    if unit.title.empty?
      self.error_empty_field("title")
    end
    if unit.value.is_a?(String) && unit.value.to_s.empty?
      self.error_empty_field("value")
    end
    # Get super collection.
    # Contains model state and dynamic field data.
    super_collection = DynFork::Globals.cache_mongo_database[
      DynFork::Globals.cache_super_collection_name]
    # Create a search filter.
    filter = {"collection_name": @@meta.not_nil![:collection_name]}
    # Get Model state.
    model_state : DynFork::Migration::ModelState = (
      document = super_collection.find_one(filter)
      DynFork::Migration::ModelState.from_bson(document)
    )
    # Check for the presence of a dynamic field.
    unless model_state.data_dynamic_fields.has_key?(unit.field)
      self.error_field_missing(unit.field)
    end
    # Get the dynamic field type.
    dyn_field_type : String = @@meta.not_nil![:field_name_and_type_list][unit.field]
    # Get dynamic field data in json format.
    json : String = model_state.data_dynamic_fields[unit.field]
    # Get clean dynamic field data.
    choices = if dyn_field_type.includes?("Text")
                Array(Tuple(String, String)).from_json(json)
              elsif dyn_field_type.includes?("I64")
                Array(Tuple(Int64, String)).from_json(json)
              elsif dyn_field_type.includes?("F64")
                Array(Tuple(Float64, String)).from_json(json)
              end
    # Insert, update or delete unit.
    if !unit.delete?
      # Insert key.
    else
      # Delete key.
    end
    # Update the state of the Model in the super collection.
    update = {"$set": {"data_dynamic_fields": data_dynamic_fields}}
    super_collection.update_one(filter, update)
    # Update metadata of the current Model.
    @@meta.not_nil![:data_dynamic_fields][unit.field] = "???"
    # Update documents in the collection of the current Model.
    if unit.delete?
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        @@meta.not_nil![:collection_name]]
      # Fetch a Cursor pointing to the  collection of current Model.
      cursor : Mongo::Cursor = collection.find
      #
      cursor.each { |_document|
        doc_h = _document.to_h
        # ???
        filter = {"_id": doc_h["_id"]}
        update = {"$set": {unit.title => "???"}}
        collection.update_one(filter, update)
      }
    end
  end

  private def error_empty_field(field : String)
    msg = "Model: `#{self.full_model_name}` > " +
          "Method: `unit_manager` > " +
          "Argument: `unit` > " +
          "Field `#{field}` => Must not be empty!"
    raise DynFork::Errors::Panic.new msg
  end

  private def error_field_missing(field : String)
    msg = "Model: `#{self.full_model_name}` > " +
          "Method: `unit_manager` => " +
          "Dynamic field `#{field}` is missing!"
    raise DynFork::Errors::Panic.new msg
  end

  private def error_key_already_exists(title : String)
    msg = "Model: `#{self.full_model_name}` > " +
          "Method: `unit_manager` => " +
          "It is not possible to add the key `#{title}`, " +
          "this key already exists!"
    raise DynFork::Errors::Panic.new msg
  end

  private def error_key_missing(title : String)
    msg = "Model: `#{self.full_model_name}` > " +
          "Method: `unit_manager` => " +
          "Cannot delete, key `#{title}` is missing!"
    raise DynFork::Errors::Panic.new msg
  end
end
