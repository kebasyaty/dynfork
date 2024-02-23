module Crymon::Paladins::Groups
  # Validation of fields of type FileField.
  def group_04(
    field_ptr : Pointer(Crymon::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
  end
end
