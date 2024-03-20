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
        cleanup_map_ptr.value[:images] << current_value.images_dir_path
        return
      end
    end

    # Return if there is no need to save.
    return unless save?

    # Create and save thumbnails.
    unless current_value.path.empty?
      images_dir_path : String = current_value.images_dir_path
      images_dir_url : String = current_value.images_dir_url
      path : String = current_value.path
      perm : File::Permissions = File::Permissions.new(0o644)
      # Create thumbnails.
      unless (thumbnails = field_ptr.value.thumbnails?).nil?
        thumbnails.sort! { |item, item2| item2[1] <=> item[1] }
        extension : String = current_value.extension
        # Get image file.
        image : Pluto::ImageRGBA = if [".jpg", ".jpeg"].includes?(extension)
          File.open(path) do |file|
            Pluto::ImageRGBA.from_jpeg(file)
          end
        elsif extension == ".png"
          File.open(path) do |file|
            Pluto::ImageRGBA.from_png(file)
          end
        elsif extension == ".webp"
          File.open(path) do |file|
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
            current_value.path_lg = "#{images_dir_path}/lg.#{extension}"
            current_value.url_lg = "#{images_dir_url}/lg.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_lg,
              content: io,
              perm: perm
            )
          when "md"
            current_value.path_md = "#{images_dir_path}/md.#{extension}"
            current_value.url_md = "#{images_dir_url}/md.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_md,
              content: io,
              perm: perm
            )
          when "sm"
            current_value.path_sm = "#{images_dir_path}/sm.#{extension}"
            current_value.url_sm = "#{images_dir_url}/sm.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_sm,
              content: io,
              perm: perm
            )
          when "xs"
            current_value.path_xs = "#{images_dir_path}/xs.#{extension}"
            current_value.url_xs = "#{images_dir_url}/xs.#{extension}"
            io = self.image_to_io_memory(image_ptr, extension, max_size)
            io.rewind
            File.write(
              filename: current_value.path_xs,
              content: io,
              perm: perm
            )
          end
        end
      end
      # Add path in cleanup map (for error_symptom=true).
      cleanup_map_ptr.value[:images] << images_dir_path
      # Insert result.
      result_bson_ptr.value[field_ptr.value.name] = current_value
    end
  end
end
