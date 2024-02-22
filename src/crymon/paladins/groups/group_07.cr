module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextMultDynField" | "ChoiceU32MultDynField"
  # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"
  def group_07(
    field_ptr : Pointer,
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool
  )
  end
end
