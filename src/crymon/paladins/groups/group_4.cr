module Crymon::Paladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextField" | "ChoiceU32Field"
  # | "ChoiceI64Field" | "ChoiceF64Field"
  def group_04(
    field_ptr : Pointer,
    is_error_symptom_ptr : Pointer(Bool),
    is_updated : Bool
  )
  end
end
