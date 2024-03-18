module DynFork::Paladins::Groups
  # Create string for SlugField.
  def group_08(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    result_bson_ptr : Pointer(BSON)
  )
    slug : String = ""
    # Insert result.
    result_bson_ptr.value[field_ptr.value.name] = slug
  end
end
