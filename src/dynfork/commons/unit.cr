# Units Management.
# NOTE: Management for `choices` parameter in dynamic field types.
module DynFork::Commons::UnitsManagement
  extend self

  # For insert, update and delete units.
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
    # Insert, update or delete unit.
    if !unit.delete?
      if model_state.data_dynamic_fields.has_key?(unit.title)
        self.error_key_already_exists(unit.title)
      end
      # Insert or update.
      model_state.data_dynamic_fields[unit.title] = unit.value.to_s
    else
      # Delete key.
      if model_state.data_dynamic_fields.delete(unit.title).nil?
        self.error_key_missing(unit.title)
      end
    end
    # Update the state of the Model in the super collection.
    update = {"$set": {"data_dynamic_fields": model_state.data_dynamic_fields}}
    super_collection.update_one(filter, update)
    # Update metadata of the current Model.
    model_state.data_dynamic_fields.each do |field_name, choices_json|
      @@meta.not_nil![:data_dynamic_fields][field_name] = choices_json
    end
    # Update documents in the collection of the current Model.
    if unit.delete?
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        @@meta.not_nil![:collection_name]]
      # Fetch a Cursor pointing to the  collection of current Model.
      cursor : Mongo::Cursor = collection.find
    end
  end

  private def error_empty_field(field : String)
    msg = "Model: `#{self.full_model_name}` > " +
          "Method: `unit_manager` > " +
          "Argument: `unit` > " +
          "Field `#{field}` => Must not be empty!"
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
