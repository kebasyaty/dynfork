module Crymon::Paladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
  # | "TextField" | "HashField" | "URLField" | "IPField"_
  #
  def group_01(
    field_ptr : Pointer,
    is_error_symptom_ptr : Pointer(Bool),
    is_updated : Bool,
    is_save : Bool,
    result_bson_ptr : Pointer(BSON)
  )
    # When updating, we skip field password type.
    if is_updated && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return
    end
    # Validation, if the field is required and empty, accumulate the error.
    # ( The default value is used whenever possible )
    if field_ptr.value.value.nil?
      if field_ptr.value.is_required?
        (is_error_symptom_ptr.value = true) unless is_error_symptom_ptr.value
        field_ptr.value.errors << "Required field."
      end
      (result_bson_ptr.value[field_ptr.value.name] = nil) if is_save
      return
    end
    # Validation the `regex` field attribute.
  end
end
