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
    msg : String = ""
    errors : String = ""
    {% for field in @type.instance_vars %}
      unless @{{ field }}.errors.empty?
        (msg = "\n# ERRORS:") if msg.empty?
        errors = (@{{ field }}.errors.clone.map { |err| "#{err}\t" }).join("\n")
        msg = "#{msg}\n#{{{ field.name.stringify }}}:\t#{errors}"
      end
    {% end %}
    line_break : String = msg.empty? ? "\n" : "\n\n"
    (msg + "#{line_break}# AlERTS:\n#{@hash.alerts.join("\n")}") unless @hash.alerts.empty?
    (msg + "\n") unless msg.empty?
    puts msg
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

  # For fill in all fields of the slug type.
  def create_slugs
    # ...
  end
end
