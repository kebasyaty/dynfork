module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextDynField" | "ChoiceU32DynField"
  # | "ChoiceI64DynField" | "ChoiceF64DynField"
  def group_05(
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool),
    is_updated? : Bool
  )
  end
end
