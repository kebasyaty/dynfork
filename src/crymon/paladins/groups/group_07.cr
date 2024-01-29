module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextMultDynField" | "ChoiceU32MultDynField"
  # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"
  def group_07(
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool),
    is_updated? : Bool
  )
  end
end
