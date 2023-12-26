module Crymon::Check::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextDynField" | "ChoiceU32DynField"
  # | "ChoiceI64DynField" | "ChoiceF64DynField"
  def group_5(field : Pointer) : Bool
    # There is no error.
    false
  end
end
