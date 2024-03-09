module DynFork::Paladins::Groups
  # Validation of fields of type FileField.
  def group_04(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    updated? : Bool,
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    cleaning_map_ptr : Pointer(NamedTuple(files: Array(String), images: Array(String)))
  )
    # Validation, if the field is required and empty, accumulate the error.
    # ( The default value is used whenever possible )
    if !updated? && field_ptr.value.value?.nil? && field_ptr.value.default?.nil?
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

    # Get current value.
    current_value : DynFork::Globals::FileData?

    if value = field_ptr.value.value?
      json : String = value.to_json
      current_value = DynFork::Globals::FileData.from_json(json)
    end

    # If necessary, use the default value.
    if !updated? && current_value.nil?
      if default = field_ptr.value.default?
        current_value = DynFork::Globals::FileData.new
        current_value.path_to_tempfile(default.to_s)
      end
    end

    # Return if the current value is missing.
    return if current_value.nil?

    # If the file needs to be delete.
    if current_value.delete? && current_value.tempfile?.nil?
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
    if current_value.size > field_ptr.value.maxsize
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
    if tempfile = current_value.tempfile
      media_root : String = field_ptr.value.media_root
      media_url : String = field_ptr.value.media_url
      target_dir : String = field_ptr.value.target_dir
      name : String = current_value.name
      # Add paths to file.
      current_value.path = "#{media_root}/#{target_dir}/#{name}"
      current_value.url = "#{media_url}/#{target_dir}/#{name}"
      cleaning_map_ptr.value[:files] << current_value.path
      # Get the path to the directory for the files.
      images_dir_path : String = "#{media_root}/#{target_dir}"
      # Create the target directory if it does not exist.
      unless Dir.exists?(images_dir_path)
        Dir.mkdir_p(path: images_dir_path, mode: 0o777)
      end
      # Save file.
      File.write(
        filename: current_value.path,
        content: File.read(tempfile.path),
        perm: File::Permissions.new(0o644)
      )
      # field_ptr.value.value = nil
      # current_value.delete_tempfile
      #
      # Insert result.
      result_bson_ptr.value[field_ptr.value.name] = current_value
    end
  end
end
