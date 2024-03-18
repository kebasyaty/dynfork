# Additional methods for Model validation.
module DynFork::Paladins::CheckPlus
  # Check data validity.
  # NOTE: The main use is to check data from web forms.
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  #
  # user = User.new
  # if user.valid?
  #   # your code...
  # end
  # ```
  #
  def valid? : Bool
    # Get the collection for the current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    self.check(pointerof(collection)).valid?
  end

  # Printing errors to the console ( for development ).
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  #
  # user = User.new
  # user.print_err unless user.valid?
  # ```
  #
  def print_err
    err? : Bool = false
    {% for field in @type.instance_vars %}
      unless @{{ field }}.errors.empty?
        # title - # ERRORS
        (puts "\n# ERRORS:".colorize.fore(:red).mode(:bold); err? = true) unless err?
        # field name
        print "## #{{{field.name.stringify}}}".colorize.fore(:green).mode(:bold)
        print " => ".colorize.fore(:cyan).mode(:bold)
        # error messages
        print @{{ field }}.errors.join("\t").colorize.fore(:red)
        # line break
        print "\n"
      end
    {% end %}
    unless @hash.alerts.empty?
      # title
      puts "# AlERTS:".colorize.fore(:yellow).mode(:bold)
      # messages
      puts (@hash.alerts.map { |item| "## #{item}" }).join("\n").colorize.fore(:yellow)
      # line break
      print "\n\n"
    end
  end

  # For accumulating errors.
  def accumulate_error(
    err_msg : String,
    field_ptr : Pointer,
    error_symptom_ptr? : Pointer(Bool)
  )
    if !field_ptr.value.hide?
      field_ptr.value.errors << err_msg
      (error_symptom_ptr?.value = true) unless error_symptom_ptr?.value
    else
      msg = ">hidden field< - Model: `#{@@meta.not_nil![:model_name]}` > " +
            "Field: `#{field_ptr.value.name}` => #{err_msg}"
      raise DynFork::Errors::Panic.new msg
    end
  end

  # Calculate the maximum size for a thumbnail.
  def calculate_thumbnail_size(
    width : Int32,
    height : Int32,
    max_size : Int32
  ) : NamedTuple(width: Int32, height: Int32)
    if width > height
      if width > max_size
        return {width: max_size, height: (height * (max_size // width))}
      end
    elsif height > max_size
      return {width: (width * (max_size // height)), height: max_size}
    end
    {width: width, height: height}
  end

  # Convert image to IO::Memory.
  def image_to_io_memory(
    image_ptr : Pointer(Pluto::ImageRGBA),
    extension : String,
    max_size : Int32
  ) : IO::Memory
    new_size = self.calculate_thumbnail_size(image_ptr.value.width, image_ptr.value.height, max_size)
    image_ptr.value.bilinear_resize!(new_size[:width], new_size[:height])
    io = IO::Memory.new
    if [".jpg", ".jpeg"].includes?(extension)
      image_ptr.value.to_jpeg(io)
    elsif extension == ".png"
      image_ptr.value.to_png(io)
    elsif extension == ".webp"
      image_ptr.value.to_lossless_webp(io)
    end
    io
  end

  # Refrash field values ​​after creating or updating a document.
  def refrash_fields(doc : BSON)
    {% for field in @type.instance_vars %}
      case @{{ field }}.group
      when 1
        # ColorField | EmailField | PasswordField | PhoneField
        # | TextField | HashField | URLField | IPField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          if @{{ field }}.field_type != "PasswordField"
            value.to_s
          else
            nil
          end
        else
          nil
        end
      when 2
        # DateField | DateTimeField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          if @{{ field }}.field_type.includes?("Time")
            value.to_s("%FT%H:%M:%S")
          else
            value.to_s("%F")
          end
        else
          nil
        end
      when 3
        # ChoiceTextField | ChoiceI64Field
        # | ChoiceF64Field | ChoiceTextMultField
        # | ChoiceI64MultField | ChoiceF64MultField
        # | ChoiceTextMultField | ChoiceI64MultField
        # | ChoiceF64MultField | ChoiceTextMultDynField
        # | ChoiceI64MultDynField | ChoiceF64MultDynField
      when 4
        # FileField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          DynFork::Globals::FileData.from_bson(value)
        else
          nil
        end
      when 5
        # ImageField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          DynFork::Globals::ImageData.from_bson(value)
        else
          nil
        end
      when 6
        # I64Field
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          value.to_i64
        else
          nil
        end
      when 7
        # F64Field
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          value.to_f64
        else
          nil
        end
      when 8
        # BoolField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          value
        else
          false
        end
      when 9
        # SlugField
        @{{ field }}.value = if !(value = doc[@{{ field }}.name]).nil?
          value.to_s
        else
          nil
        end
      else
        raise DynFork::Errors::Model::InvalidGroupNumber
          .new(self.model_name, {{ field.name.stringify }})
      end
    {% end %}
  end
end
