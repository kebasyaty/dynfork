module DynFork::Paladins::Groups
  # Validation of fields of type F64Field.
  def group_07(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
    # Get current value.
    current_value : Float64 = (
      value : DynFork::Globals::ValueTypes = field_ptr.value.value? || field_ptr.value.default?
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
        (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
        return
      end
      value.to_s.to_f64
    )
    # Validation the `max` field attribute.
    if max = field_ptr.value.max?
      if current_value > max.to_f64
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
    if min = field_ptr.value.min?
      if current_value < min.to_f64
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
       !collection_ptr.value.find_one({field_ptr.value.name => current_value}).nil?
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Insert result.
    (result_bson_ptr.value[field_ptr.value.name] = current_value) if save?
  end
end
