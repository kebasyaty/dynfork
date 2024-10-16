# Tools - A set of additional auxiliary methods for Paladins.
module DynFork::QPaladins::Tools
  # Check data validity.
  # NOTE: the main use is to check data from web forms.
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
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    self.check(pointerof(collection)).valid?
  end

  # Printing errors to the console.
  # Convenient to use during development.
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
  def print_err : Nil
    err? : Bool = false
    {% for field in @type.instance_vars %}
      unless @{{ field }}.errors.empty?
        # title - # ERRORS
        (
          puts "\nERRORS:".colorize.fore(:red).mode(:bold)
          puts "Model: `#{@@full_model_name}`".colorize.fore(:blue).mode(:bold)
          err? = true
        ) unless err?
        # field name
        print "#{{{field.name.stringify}}}".colorize.fore(:green).mode(:bold)
        print " => ".colorize.fore(:blue).mode(:bold)
        # error messages
        print @{{ field }}.errors.join(" || ").colorize.fore(:red)
        # line break
        print "\n"
      end
    {% end %}
    unless @hash.alerts.empty?
      # title
      puts "AlERTS:".colorize.fore(:yellow).mode(:bold)
      # messages
      puts @hash.alerts.join("\n").colorize.fore(:yellow)
      # line break
      print "\n\n"
    end
  end

  # :nodoc:
  def accumulate_error(
    err_msg : String,
    field_ptr : Pointer,
    error_symptom_ptr? : Pointer(Bool)
  ) : Nil
    # For accumulating errors.
    #
    if !field_ptr.value.hide?
      field_ptr.value.errors << err_msg
      (error_symptom_ptr?.value = true) unless error_symptom_ptr?.value
    else
      msg = ">hidden field< - Model: `#{@@full_model_name}` > " +
            "Field: `#{field_ptr.value.name}` => #{err_msg}"
      raise DynFork::Errors::Panic.new msg
    end
  end

  # :nodoc:
  def calculate_thumbnail_size(
    width : Int32,
    height : Int32,
    max_size : Int32
  ) : NamedTuple(width: Int32, height: Int32)
    # Calculate the maximum size for a thumbnail.
    #
    width_big : BigDecimal = BigDecimal.new(width)
    height_big : BigDecimal = BigDecimal.new(height)
    max_size_big : BigDecimal = BigDecimal.new(max_size)
    #
    if width > height
      if width > max_size
        return {width: max_size, height: (height_big * (max_size_big / width_big)).to_i32}
      end
    elsif height > max_size
      return {width: ((width_big * (max_size_big / height_big)).to_i32), height: max_size}
    end
    {width: width, height: height}
  end

  # :nodoc:
  def image_to_io_memory(
    image_ptr : Pointer(Pluto::ImageRGBA),
    extension : String,
    max_size : Int32
  ) : IO::Memory
    # Convert image to IO::Memory.
    #
    new_size = self.calculate_thumbnail_size(
      image_ptr.value.width,
      image_ptr.value.height,
      max_size
    )
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

  # :nodoc:
  def check_uniqueness?(
    current_value : String | Time | Int64 | Float64,
    collection_ptr : Pointer(Mongo::Collection),
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    id_ptr : Pointer(BSON::ObjectId?)
  ) : Bool
    # Check the uniqueness of the value in the database.
    #
    filter = {
      "$and": [
        {_id: {"$ne": id_ptr.value}},
        {field_ptr.value.name => current_value},
      ],
    }
    collection_ptr.value.find_one(filter).nil?
  end

  # Delete a document from a collection in a database.
  def delete : Nil
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    unless @@meta.not_nil![:delete_doc?]
      raise DynFork::Errors::Meta::ForbiddenDeletingDocs.new
    end
    # Get collection.
    collection : Mongo::Collection = DynFork::Globals.mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get the ID and delete the document.
    if id : BSON::ObjectId? = self.object_id
      # Run hook.
      self.pre_delete
      # Delete doc.
      collection.delete_one({_id: id})
      # Reset field values.
      {% for field in @type.instance_vars %}
        @{{ field }}.value =  nil
      {% end %}
      # Run hook.
      self.post_delete
    else
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Field: `hash` > " +
        "Param: `value` => Hash is missing."
      )
    end
  end

  # :nodoc:
  def restor_ignored_fields(update? : Bool = false) : Nil
    # Reset the values ​​of ignored fields to nil.
    #
    {% for field in @type.instance_vars %}
      if @{{ field }}.ignored? && (@{{ field }}.name != "hash" || !update?)
          @hash.value = nil
      end
    {% end %}
  end

  # Refrash field values ​​after creating or updating a document.
  def refrash_fields(doc_bson : BSON) : Nil
    field_type : String = ""
    name : String = ""
    doc_hash = doc_bson.to_h
    @hash.value = doc_hash["_id"].as(BSON::ObjectId).to_s
    #
    {% for field in @type.instance_vars %}
      name = @{{ field }}.name
      #
      if !@{{ field }}.ignored?
        field_type = @{{ field }}.field_type
        if !(value = doc_hash[name]).nil?
          case @{{ field }}.group
          when 1
            # ColorField | EmailField | PasswordField | PhoneField
            # | TextField | HashField | URLField | IPField
            if field_type != "PasswordField"
              @{{ field }}.refrash_val_str(value.as(String))
            else
              @{{ field }}.value =  nil
            end
          when 2
            # DateField | DateTimeField
            if field_type.includes?("Time")
              @{{ field }}.refrash_val_datetime(value.as(Time))
            else
              @{{ field }}.refrash_val_date(value.as(Time))
            end
          when 3
            # ChoiceTextField | ChoiceTextMultField
            # | ChoiceTextDynField | ChoiceTextMultDynField
            # | ChoiceI64Field | ChoiceI64MultField
            # | ChoiceI64DynField | ChoiceI64MultDynField
            # | ChoiceF64Field | ChoiceF64MultField
            # | ChoiceF64DynField | ChoiceF64MultDynField
            if field_type.includes?("Text")
              if field_type.includes?("Mult")
                arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(String)}
                @{{ field }}.refrash_val_arr_str(arr)
              else
                @{{ field }}.refrash_val_str(value.as(String))
              end
            elsif field_type.includes?("I64")
              if field_type.includes?("Mult")
                arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(Int64)}
                @{{ field }}.refrash_val_arr_i64(arr)
              else
                @{{ field }}.refrash_val_i64(value.as(Int64))
              end
            elsif field_type.includes?("F64")
              if field_type.includes?("Mult")
                arr = value.as(Array(BSON::RecursiveValue)).map { |item| item.as(Float64)}
                @{{ field }}.refrash_val_arr_f64(arr)
              else
                @{{ field }}.refrash_val_f64(value.as(Float64))
              end
            end
          when 4
            # FileField
            bson = BSON.new
            value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
            @{{ field }}.refrash_val_file_data(
              DynFork::Globals::FileData.from_bson(bson))
          when 5
            # ImageField
            bson = BSON.new
            value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
            @{{ field }}.refrash_val_img_data(
              DynFork::Globals::ImageData.from_bson(bson))
          when 6
            # I64Field
            @{{ field }}.refrash_val_i64(value.as(Int64))
          when 7
            # F64Field
            @{{ field }}.refrash_val_f64(value.as(Float64))
          when 8
            # BoolField
            @{{ field }}.refrash_val_bool(value.as(Bool))
          when 9
            # SlugField
            @{{ field }}.refrash_val_str(value.as(String))
          else
            raise DynFork::Errors::Model::InvalidGroupNumber
              .new(@@full_model_name, {{ field.name.stringify }})
          end
        else
            @{{ field }}.value =  nil
        end
      else
          (@{{ field }}.value = nil) if name != "hash"
      end
    {% end %}
  end
end
