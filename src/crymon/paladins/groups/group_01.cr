module Crymon::Paladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
  # | "TextField" | "HashField" | "URLField" | "IPField"_
  #
  def group_01(
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool),
    is_updated? : Bool,
    is_save? : Bool,
    result_bson_ptr : Pointer(BSON)
  )
    # When updating, we skip field password type.
    if is_updated? && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return
    end
    # Get current value.
    current_value : String = (
      value = field_ptr.value.value || field_ptr.value.default
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil?
        if field_ptr.value.is_required?
          field_ptr.value.errors << I18n.t(:required_field)
          (is_error_symptom_ptr?.value = true) unless is_error_symptom_ptr?.value
        end
        (result_bson_ptr.value[field_ptr.value.name] = nil) if is_save?
        return
      end
      value.to_s
    )
    # Validation the `regex` field attribute.
    if pattern = field_ptr.value.regex
      unless /#{pattern}/.matches?(current_value)
        unless field_ptr.value.is_hide?
          field_ptr.value.errors << field_ptr.value.regex_err_msg.to_s
          (is_error_symptom_ptr?.value = true) unless is_error_symptom_ptr?.value
        else
          raise "Panic - Model: `#{@@meta.not_nil![:model_name]}` > " +
                "Field: `#{field_ptr.value.name}` => #{field_ptr.value.regex_err_msg}"
        end
      end
    end
    # Validation `maxlength`.
    if maxlength = field_ptr.value.maxlength
      unless Valid.max? current_value, maxlength
        msg = I18n.t(
          "number_not_greater_max.interpolation",
          curr_num: current_value.size,
          max_num: maxlength
        )
        unless field_ptr.value.is_hide?
          field_ptr.value.errors << msg
          (is_error_symptom_ptr?.value = true) unless is_error_symptom_ptr?.value
        else
          raise "Panic - Model: `#{@@meta.not_nil![:model_name]}` > " +
                "Field: `#{field_ptr.value.name}` > Attribute: `maxlength` => #{msg}"
        end
      end
    end
    # Validation `minlength`.
    if minlength = field_ptr.value.minlength
      unless Valid.min? current_value, minlength
        msg = I18n.t(
          "number_not_less_min.interpolation",
          curr_num: current_value.size,
          min_num: minlength
        )
        unless field_ptr.value.is_hide?
          field_ptr.value.errors << msg
          (is_error_symptom_ptr?.value = true) unless is_error_symptom_ptr?.value
        else
          raise "Panic - Model: `#{@@meta.not_nil![:model_name]}` > " +
                "Field: `#{field_ptr.value.name}` > Attribute: `minlength` => #{msg}"
        end
      end
    end
  end
end
