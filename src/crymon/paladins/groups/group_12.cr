module Crymon::Paladins::Groups
  # Validation of fields of type BoolField.
  def group_12(
    field_ptr : Pointer,
    save? : Bool,
    result_bson_ptr : Pointer(BSON)
  )
    current_value : Bool = false
    (current_value = true) if field_ptr.value.value || field_ptr.value.default
    # Insert result.
    (result_bson_ptr.value[field_ptr.value.name] = current_value) if save?
  end
end
