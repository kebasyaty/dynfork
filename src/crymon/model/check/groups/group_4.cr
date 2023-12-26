module Crymon::Check::Groups
  # Validation of `choice` type fields:
  # <br>
  # "ChoiceTextField" | "ChoiceU32Field"
  # | "ChoiceI64Field" | "ChoiceF64Field"
  def group_4(field : Pointer) : Bool
    # There is no error.
    false
  end
end
