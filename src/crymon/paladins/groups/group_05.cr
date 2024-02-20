module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextDynField" | "ChoiceU32DynField"
  # | "ChoiceI64DynField" | "ChoiceF64DynField"
  def group_05(
    field_ptr : Pointer,
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool
  )
  end
end
