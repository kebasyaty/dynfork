module DynFork::QPaladins::Groups
  # Validation of fields of type `FileField`.
  # NOTE: This method is used within the `DynFork::QPaladins::Check#check` method.
  def group_04(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    update? : Bool,
    save? : Bool,
    result_map : Hash(String, DynFork::Globals::ResultMapType),
  ) : Nil
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
      (result_map[field_ptr.value.name] = nil) if save?
      return
    end

    # Get current value.
    _current_value : DynFork::Globals::FileData? = field_ptr.value.extract_file_data

    # If necessary, use the default value.
    if !update? && _current_value.nil?
      if default = field_ptr.value.default?
        field_ptr.value.from_path(default.to_s)
        _current_value = field_ptr.value.extract_file_data
      end
    end

    # Return if the current value is missing
    return if _current_value.nil?

    current_value : DynFork::Globals::FileData = _current_value.not_nil!
    _current_value = nil

    # If the file needs to be delete.
    if current_value.delete? && current_value.path.empty?
      if default = field_ptr.value.default?
        field_ptr.value.from_path(default.to_s)
        current_value = field_ptr.value.extract_file_data.not_nil!
      else
        if !field_ptr.value.required?
          (result_map[field_ptr.value.name] = nil) if save?
        else
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            error_symptom_ptr?
          )
        end
        return
      end
    end

    # Accumulate an error if the file size exceeds the maximum value.
    if current_value.size > field_ptr.value.maxsize
      self.accumulate_error(
        I18n.t(:size_exceeds_max),
        field_ptr,
        error_symptom_ptr?
      )
      return
    end

    # Return if there is no need to save.
    unless save?
      if current_value.new_file_data?
        File.delete(current_value.not_nil!.path)
        field_ptr.value.value = nil
      end
      return
    end

    # Insert result.
    if current_value.new_file_data? || current_value.save_as_is?
      current_value.new_file_data = false
      current_value.delete = false
      current_value.save_as_is = true
      result_map[field_ptr.value.name] = current_value
    end
  end
end
