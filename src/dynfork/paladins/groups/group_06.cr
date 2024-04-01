module DynFork::Paladins::Groups
  # Validation of fields of type _I64Field_.
  def group_06(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_map_ptr : Pointer(Hash(String, DynFork::Globals::ResultMapType)),
    collection_ptr : Pointer(Mongo::Collection),
    id_ptr : Pointer(BSON::ObjectId?)
  )
    # Get current value.
    current_value : Int64 = (
      value : Int64? = field_ptr.value.extract_val_i64? || field_ptr.value.extract_default_i64?
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil?
        if field_ptr.value.required?
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            error_symptom_ptr?
          )
        end
        (result_map_ptr.value[field_ptr.value.name] = nil) if save?
        return
      end
      value.as(Int64)
    )
    # Validation the `max` field attribute.
    unless (max = field_ptr.value.max?).nil?
      if current_value > max.to_i64
        err_msg = I18n.t(
          "number_not_greater_max.interpolation",
          curr_num: current_value,
          max_num: max
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `min` field attribute.
    unless (min = field_ptr.value.min?).nil?
      if current_value < min.to_i64
        err_msg = I18n.t(
          "number_not_less_min.interpolation",
          curr_num: current_value,
          min_num: min
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `unique` field attribute.
    if field_ptr.value.unique? &&
       !self.check_uniqueness?(current_value, collection_ptr, field_ptr, id_ptr)
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Insert result.
    (result_map_ptr.value[field_ptr.value.name] = current_value) if save?
  end
end
