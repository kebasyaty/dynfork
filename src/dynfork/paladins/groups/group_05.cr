module DynFork::Paladins::Groups
  # Validation of fields of type ImageField.
  def group_05(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    update? : Bool,
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
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
      (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
      return
    end

    # Get current value.
    current_value : DynFork::Globals::ImageData? = field_ptr.value.extract_img_data

    # If necessary, use the default value.
    if !update? && current_value.nil?
      if default = field_ptr.value.default
        field_ptr.value.path_to_file(default.to_s)
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
        (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
      end
      # Add path in cleanup map.
      cleanup_map_ptr.value[:images] << current_value.images_dir
      return
    end

    # Accumulate an error if the file size exceeds the maximum value.
    if current_value.size > field_ptr.value.maxsize
      self.accumulate_error(
        I18n.t(:size_exceeds_max),
        field_ptr,
        error_symptom_ptr?
      )
      # Add path in cleanup map.
      cleanup_map_ptr.value[:images] << current_value.images_dir
      return
    end

    # Return if there is no need to save.
    return unless save?

    # Get the paths value and save the file.
    unless (tempfile = current_value.tempfile?).nil?
      media_root : String = field_ptr.value.media_root
      media_url : String = field_ptr.value.media_url
      target_dir : String = field_ptr.value.target_dir
      images_dir : String = current_value.images_dir
      name : String = current_value.name
      # Add paths to original image.
      date : String = Time.utc.to_s("%Y-%m-%d")
      current_value.path = "#{media_root}/#{target_dir}/#{date}/#{images_dir}/#{name}"
      current_value.url = "#{media_url}/#{target_dir}/#{date}/#{images_dir}/#{name}"
      # Get the directory path for the image.
      images_dir_path : String = "#{media_root}/#{target_dir}/#{date}/#{images_dir}"
      cleanup_map_ptr.value[:images] << images_dir_path
      # Create the target directory if it does not exist.
      unless Dir.exists?(images_dir_path)
        Dir.mkdir_p(path: images_dir_path, mode: 0o777)
      end
      #
      tempfile_path : String = tempfile.path
      # Save original image.
      File.write(
        filename: current_value.path,
        content: File.read(tempfile_path),
        perm: File::Permissions.new(0o644)
      )
      # Create and save thumbnails.
      unless (thumbnails = field_ptr.value.thumbnails?).nil?
        thumbnails.sort! { |item, item2| item2[1] <=> item[1] }
        extension : String = current_value.extension
        # Get image file.
        image : Pluto::ImageRGBA = if [".jpg", ".jpeg"].includes?(extension)
          File.open(tempfile_path) do |file|
            Pluto::ImageRGBA.from_jpeg(file)
          end
        elsif extension == ".png"
          File.open(tempfile_path) do |file|
            Pluto::ImageRGBA.from_png(file)
          end
        elsif extension == ".webp"
          File.open(tempfile_path) do |file|
            Pluto::ImageRGBA.from_webp(file)
          end
        else
          err_msg = I18n.t(
            "invalid_file_type.interpolation",
            type: extension.upcase
          )
          self.accumulate_error(
            err_msg,
            field_ptr,
            error_symptom_ptr?
          )
          return
        end
        image_ptr : Pointer(Pluto::ImageRGBA) = pointerof(image)
        #
        current_value.width = image.width
        current_value.height = image.height
        #
        thumbnails.each do |(size_name, max_size)|
          case size_name
          when "lg"
            current_value.path_lg = "#{media_root}/#{target_dir}/#{date}/#{images_dir}/lg.#{extension}"
            current_value.url_lg = "#{media_url}/#{target_dir}/#{date}/#{images_dir}/lg.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_lg,
              content: io,
              perm: File::Permissions.new(0o644)
            )
          when "md"
            current_value.path_md = "#{media_root}/#{target_dir}/#{date}/#{images_dir}/md.#{extension}"
            current_value.url_md = "#{media_url}/#{target_dir}/#{date}/#{images_dir}/md.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_md,
              content: io,
              perm: File::Permissions.new(0o644)
            )
          when "sm"
            current_value.path_sm = "#{media_root}/#{target_dir}/#{date}/#{images_dir}/sm.#{extension}"
            current_value.url_sm = "#{media_url}/#{target_dir}/#{date}/#{images_dir}/sm.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_sm,
              content: io,
              perm: File::Permissions.new(0o644)
            )
          when "xs"
            current_value.path_xs = "#{media_root}/#{target_dir}/#{date}/#{images_dir}/xs.#{extension}"
            current_value.url_xs = "#{media_url}/#{target_dir}/#{date}/#{images_dir}/xs.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_xs,
              content: io,
              perm: File::Permissions.new(0o644)
            )
          end
        end
      end
      #
      # Insert result.
      result_bson_ptr.value[field_ptr.value.name] = current_value
    end
  end
end
