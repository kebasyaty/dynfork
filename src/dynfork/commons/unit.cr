# Units Management.
# NOTE: Management for `choices` parameter in dynamic field types.
module DynFork::QCommons::UnitsManagement
  extend self

  # For insert or delete units.
  # NOTE: Management for `choices` parameter in dynamic field types.
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "TestModel")]
  # struct ModelName < DynFork::Model
  #   getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
  #   getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new
  #   getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
  #   getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new
  #   getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
  #   getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new
  # end
  #
  # unit = DynFork::Globals::Unit.new(
  #   field: "field_name",
  #   title: "Title",
  #   value: "value", # String | Int64 | Float64
  #   delete: false   # default is the same as `false`
  # )
  #
  # ModelName.unit_manager unit
  # ```
  #
  def unit_manager(
    unit : DynFork::Globals::Unit,
  ) : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
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
    super_collection = DynFork::Globals.mongo_database[
      DynFork::Globals.super_collection_name]
    # Get Model state.
    model_state : DynFork::Migration::ModelState = (
      document = super_collection.find_one(
        filter: {"collection_name": @@meta.not_nil![:collection_name]}
      )
      DynFork::Migration::ModelState.from_bson(document.not_nil!)
    )
    # Check for the presence of a dynamic field.
    unless model_state.data_dynamic_fields.has_key?(unit.field)
      self.error_field_missing(unit.field)
    end
    # Get the dynamic field type.
    dyn_field_type : String = model_state.field_name_and_type_list[unit.field]
    # Get dynamic field data in json format.
    data_df_json : String = model_state.data_dynamic_fields[unit.field]
    # Check the presence of the key (title) and value.
    key_exists? : Bool = false
    value_match? : Bool = true
    # Get clean dynamic field data.
    choices : Array(Tuple(Float64 | Int64 | String, String)) = (
      if dyn_field_type.includes?("Text")
        choices_text = Array(Tuple(String, String)).from_json(data_df_json)
        key_exists? = (choices_text.map { |item| item[1] }).includes?(unit.title)
        (value_match? = choices_text.includes?({unit.value.to_s, unit.title})) if unit.delete?
        choices_text.map { |item| {item[0].as(Float64 | Int64 | String), item[1]} }
      elsif dyn_field_type.includes?("I64")
        choices_i64 = Array(Tuple(Int64, String)).from_json(data_df_json)
        key_exists? = (choices_i64.map { |item| item[1] }).includes?(unit.title)
        (value_match? = choices_i64.includes?({unit.value.to_i64, unit.title})) if unit.delete?
        choices_i64.map { |item| {item[0].as(Float64 | Int64 | String), item[1]} }
      elsif dyn_field_type.includes?("F64")
        choices_f64 = Array(Tuple(Float64, String)).from_json(data_df_json)
        key_exists? = (choices_f64.map { |item| item[1] }).includes?(unit.title)
        (value_match? = choices_f64.includes?({unit.value.to_f64, unit.title})) if unit.delete?
        choices_f64.map { |item| {item[0].as(Float64 | Int64 | String), item[1]} }
      else
        self.error_invalid_field_type(dyn_field_type)
      end
    )
    #
    choices_json : String = ""
    # Insert or delete unit.
    if !unit.delete?
      self.error_key_already_exists(unit.title) if key_exists?
      # Insert key-value.
      choices << {unit.value, unit.title}
      choices_json = choices.to_json
      model_state.data_dynamic_fields[unit.field] = choices_json
    else
      self.error_key_missing(unit.title) unless key_exists?
      self.error_value_not_match(unit.title, unit.value) unless value_match?
      # Delete key-value.
      choices.select! { |item| item[1] != unit.title }
      choices_json = choices.to_json
      model_state.data_dynamic_fields[unit.field] = choices_json
    end
    # Update the state of the Model in the super collection.
    super_collection.replace_one(
      filter: {"collection_name": model_state.collection_name},
      replacement: model_state.to_bson,
    )
    # Update metadata of the current Model.
    @@meta.not_nil![:data_dynamic_fields][unit.field] = choices_json
    #
    # Update documents in the collection of the current Model.
    if unit.delete?
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.mongo_database[
        @@meta.not_nil![:collection_name]]
      # Fetch a Cursor pointing to the  collection of current Model.
      cursor : Mongo::Cursor = collection.find
      #
      cursor.each do |doc|
        doc_h = doc.to_h
        # Update field value in document.
        if !(value = doc_h[unit.field]).nil?
          if dyn_field_type.includes?("Mult")
            if dyn_field_type.includes?("Text")
              arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(String) }
              arr.delete(unit.value.to_s)
              doc[unit.field] = !arr.empty? ? arr : nil
            elsif dyn_field_type.includes?("I64")
              arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(Int64) }
              arr.delete(unit.value.to_i64)
              doc[unit.field] = !arr.empty? ? arr : nil
            elsif dyn_field_type.includes?("F64")
              arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(Float64) }
              arr.delete(unit.value.to_f64)
              doc[unit.field] = !arr.empty? ? arr : nil
            else
              self.error_invalid_field_type(dyn_field_type)
            end
          else
            doc[unit.field] = nil
          end
        end
        # Update the value of a field in the collection of the current Model.
        collection.replace_one(
          filter: {_id: doc["_id"]},
          replacement: doc,
        )
      end
    end
  end

  # Error: If any of the fields in the Unit is empty.
  private def error_empty_field(field : String)
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` > " +
          "Argument: `unit` > " +
          "Field `#{field}` => must not be empty!"
    raise DynFork::Errors::Panic.new msg
  end

  # Error: If the Model does not have a dynamic field specified in Unit.
  private def error_field_missing(field : String)
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` => " +
          "The Model is missing a dynamic field `#{field}`!"
    raise DynFork::Errors::Panic.new msg
  end

  # Error: If the field type does not match.
  private def error_invalid_field_type(field_type : String)
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` => " +
          "Invalid dynamic field type `#{field_type}`!"
    raise DynFork::Errors::Panic.new msg
  end

  # Error: When try to add existing data.
  private def error_key_already_exists(title : String)
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` => " +
          "Cannot add a new unit, the `#{title}` key is already present!"
    raise DynFork::Errors::Panic.new msg
  end

  # Error: When try to delete data that doesn't exist.
  private def error_key_missing(title : String)
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` => " +
          "It is impossible to delete a unit, the `#{title}` key is missing!"
    raise DynFork::Errors::Panic.new msg
  end

  # Error: When try to delete data that doesn't exist.
  private def error_value_not_match(
    title : String,
    value : String | Int64 | Float64,
  )
    msg = "Model: `#{@@full_model_name}` > " +
          "Method: `.unit_manager` => " +
          "It is impossible to delete an object, " +
          "the key `#{title}` does not contain the value `#{value}`!"
    raise DynFork::Errors::Panic.new msg
  end
end
