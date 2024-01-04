module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextMultField" | "ChoiceU32MultField"
  # | "ChoiceI64MultField" | "ChoiceF64MultField"
  def group_06(
    field_ptr : Pointer,
    is_error_symptom_ptr : Pointer(Bool),
    is_updated : Bool
  )
  end
end
