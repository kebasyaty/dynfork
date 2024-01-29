module Crymon::Paladins::Groups
  # Validation of fields of type I64Field.
  def group_10(
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool),
    is_save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
    # Get current value.
    current_value : Int64 = (
      value = field_ptr.value.value || field_ptr.value.default
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil?
        if field_ptr.value.is_required?
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            is_error_symptom_ptr?
          )
        end
        (result_bson_ptr.value[field_ptr.value.name] = nil) if is_save?
        return
      end
      value.to_s.to_i64
    )
    # Validation the `max` field attribute.
    if max = field_ptr.value.max.not_nil!.to_i64
      if current_value > max
        err_msg = I18n.t(
          "number_not_greater_max.interpolation",
          curr_num: current_value,
          max_num: max
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          is_error_symptom_ptr?
        )
      end
    end
    # Validation the `min` field attribute.
    if min = field_ptr.value.min.not_nil!.to_i64
      if current_value < min
        err_msg = I18n.t(
          "number_not_less_min.interpolation",
          curr_num: current_value,
          min_num: min
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          is_error_symptom_ptr?
        )
      end
    end
    # Validation the `is_unique` field attribute.
    if field_ptr.value.is_unique? &&
       !collection_ptr.value.find_one({field_ptr.value.name => current_value}).nil?
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        is_error_symptom_ptr?
      )
    end
    # Insert result.
    (result_bson_ptr.value[field_ptr.value.name] = current_value) if is_save?
  end
end
