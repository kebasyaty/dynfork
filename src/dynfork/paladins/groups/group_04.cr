module DynFork::Paladins::Groups
  # Validation of fields of type FileField.
  def group_04(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool,
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
    # Validation, if the field is required and empty, accumulate the error.
    # ( The default value is used whenever possible )
    if !updated? && field_ptr.value.value.nil? && field_ptr.value.default.nil?
      if field_ptr.value.required?
        self.accumulate_error(
          I18n.t(:required_field),
          field_ptr,
          error_symptom_ptr?
        )
      end
      (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
      return
    end

    # If necessary, use the default value.
    if !updated? && field_ptr.value.value.nil?
      if default = field_ptr.value.default
        field_ptr.value.value = DynFork::Globals::FileData.new
          .path_to_tempfile(default)
      end
    end

    # Return if the value is missing.
    return if field_ptr.value.value.nil?

    # If the file needs to be delete.
    if field_ptr.value.value.delete? && field_ptr.value.value.tempfile.nil?
      if field_ptr.value.required?
        self.accumulate_error(
          I18n.t(:required_field),
          field_ptr,
          error_symptom_ptr?
        )
      else
        (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
      end
      return
    end
  end
end
