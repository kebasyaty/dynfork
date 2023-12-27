module Crymon::Paladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
  # | "TextField" | "HashField" | "URLField" | "IPField"_
  #
  def group_1(field_ptr : Pointer, is_updated : Bool) : Bool
    # When updating, we skip field password type.
    if is_updated && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return false
    end
    # There is no error.
    false
  end
end
