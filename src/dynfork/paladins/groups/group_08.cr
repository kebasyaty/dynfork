module DynFork::QPaladins::Groups
  # Validation of fields of type BoolField.
  # NOTE: This method is used within the `DynFork::QPaladins::Check#check` method.
  def group_08(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    save? : Bool,
    result_map : Hash(String, DynFork::Globals::ResultMapType),
  ) : Nil
    #
    current_value : Bool = false
    if !(val = field_ptr.value.extract_val_bool).nil?
      current_value = val.not_nil!
    elsif !(val = field_ptr.value.extract_default_bool).nil?
      current_value = val.not_nil!
    end
    # Insert result.
    (result_map[field_ptr.value.name] = current_value) if save?
  end
end
