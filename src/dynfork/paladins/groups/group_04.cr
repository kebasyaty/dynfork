module DynFork::Paladins::Groups
  # Validation of fields of type FileField.
  def group_04(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    update? : Bool,
    save? : Bool,
    result_map_ptr : Pointer(Hash(String, DynFork::Globals::ResultMapType)),
    cleanup_map_ptr : Pointer(NamedTuple(files: Array(String), images: Array(String)))
  )
    # Validation, if the field is required and empty, accumulate the error.
    # ( The default value is used whenever possible )
    if !update? && field_ptr.value.value?.nil? && field_ptr.value.default?.nil?
      if field_ptr.value.required?
        self.accumulate_error(
          I18n.t(:required_field),
          field_ptr,
          error_symptom_ptr?
        )
      end
      (result_map_ptr.value[field_ptr.value.name] = nil) if save?
      return
    end

    # Get current value.
    current_value : DynFork::Globals::FileData? = field_ptr.value.extract_file_data

    # If necessary, use the default value.
    if !update? && current_value.nil?
      if default = field_ptr.value.default?
        field_ptr.value.path_to_file(default.to_s)
        current_value = field_ptr.value.extract_file_data
      end
    end

    # Return if the current value is missing.
    return if current_value.nil?

    # If the file needs to be delete.
    if current_value.delete? && current_value.path.empty?
      if field_ptr.value.required?
        self.accumulate_error(
          I18n.t(:required_field),
          field_ptr,
          error_symptom_ptr?
        )
      else
        (result_map_ptr.value[field_ptr.value.name] = nil) if save?
      end
      return
    end

    # Accumulate an error if the file size exceeds the maximum value.
    unless current_value.path.empty?
      if current_value.size > field_ptr.value.maxsize
        self.accumulate_error(
          I18n.t(:size_exceeds_max),
          field_ptr,
          error_symptom_ptr?
        )
        # Add path in cleanup map.
        cleanup_map_ptr.value[:files] << current_value.path
        return
      end
    end

    # Return if there is no need to save.
    return unless save?

    #
    unless current_value.path.empty?
      # Add path in cleanup map (for error_symptom=true).
      cleanup_map_ptr.value[:files] << current_value.path
      # Insert result.
      result_map_ptr.value[field_ptr.value.name] = current_value
    end
  end
end
