module Crymon::Paladins::Groups
  # Validation of fields of type I64Field.
  def group_10(
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool),
    is_save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
  end
end
