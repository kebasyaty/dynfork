module Crymon::Paladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
  # | "TextField" | "HashField" | "URLField" | "IPField"_
  #
  def group_1(
    field_ptr : Pointer,
    is_error_symptom_ptr : Pointer(Bool),
    is_updated : Bool
  )
    # When updating, we skip field password type.
    if is_updated && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return
    end
  end
end
