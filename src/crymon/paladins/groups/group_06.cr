module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextMultField" | "ChoiceU32MultField"
  # | "ChoiceI64MultField" | "ChoiceF64MultField"
  def group_06(
    field_ptr : Pointer,
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool
  )
  end
end
