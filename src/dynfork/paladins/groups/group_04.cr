module DynFork::Paladins::Groups
  # Validation of fields of type FileField.
  def group_04(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool,
    save? : Bool,
    result_bson_ptr : Pointer(BSON)
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
    if field_ptr.value.value.not_nil!.delete? && field_ptr.value.value.not_nil!.tempfile.nil?
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

    # Accumulate an error if the file size exceeds the maximum value.
    if field_ptr.value.value.not_nil!.size > field_ptr.value.maxsize
      self.accumulate_error(
        I18n.t(:size_exceeds_max),
        field_ptr,
        error_symptom_ptr?
      )
      return
    end

    # Return if there is no need to save.
    return if !save?

    # Get the paths value and save the file.
    if tempfile = field_ptr.value.value.not_nil!.tempfile
      media_root = field_ptr.value.media_root
      media_url = field_ptr.value.media_url
      target_dir = field_ptr.value.target_dir
      name = field_ptr.value.value.not_nil!.name
      field_ptr.value.value.path = "#{media_root}/#{target_dir}/#{name}"
      field_ptr.value.value.url = "#{media_url}/#{target_dir}/#{name}"
      Dir.mkdir_p(path: "#{media_root}/#{target_dir}", mode: 0o777)
      File.write(
        filename: field_ptr.value.value.not_nil!.path,
        content: File.read(tempfile.path),
        perm: File::Permissions.new(0o644)
      )
      field_ptr.value.value.not_nil!.delete_tempfile
      # Insert result.
      result_bson_ptr.value[field_ptr.value.name] = field_ptr.value.value.not_nil!
    else
      # Insert result.
      result_bson_ptr.value[field_ptr.value.name] = nil
    end
  end
end
