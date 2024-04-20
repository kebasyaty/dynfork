# **Fixtures** - To populate the database with pre-created data.
# <br>
# **config/fixtures** - Directory for creating fixtures.
module DynFork::Paladins::Fixtures
  # Apply fixture for current Model.
  # WARNING: Runs automatically during Model migration.
  def apply_fixture(
    fixture_name : String?,
    collection_ptr : Pointer(Mongo::Collection)
  ) : Nil
    fixture_path : String = "config/fixtures/#{fixture_name}.yml"
    yaml_arr = YAML.parse_all(File.read(fixture_path))
    #
    yaml_arr.each do |yaml|
      {% for field in @type.instance_vars %}
        unless @{{ field }}.ignored?
          unless (value = yaml[@{{ field }}.name]?).nil?
            field_type = @{{ field }}.field_type
            case @{{ field }}.group
            when 1
              # ColorField | EmailField | PasswordField | PhoneField
              # | TextField | HashField | URLField | IPField
              @{{ field }}.refrash_val_str(value.as_s)
            when 2
              # DateField | DateTimeField
              if field_type.includes?("Time")
                dt = self.datetime_parse(value.as_s)
                @{{ field }}.refrash_val_datetime(dt)
              else
                dt = self.date_parse(value.as_s)
                @{{ field }}.refrash_val_date(dt)
              end
            when 3
              # ChoiceTextField | ChoiceI64Field
              # | ChoiceF64Field | ChoiceTextMultField
              # | ChoiceI64MultField | ChoiceF64MultField
              # | ChoiceTextMultField | ChoiceI64MultField
              # | ChoiceF64MultField | ChoiceTextMultDynField
              # | ChoiceI64MultDynField | ChoiceF64MultDynField
              if field_type.includes?("Text")
                if field_type.includes?("Mult")
                  arr = value.as_a.map { |item| item.as_s}
                  @{{ field }}.refrash_val_arr_str(arr)
                else
                  @{{ field }}.refrash_val_str(value.as_s)
                end
              elsif field_type.includes?("I64")
                if field_type.includes?("Mult")
                  arr = value.as_a.map { |item| item.as_i64}
                  @{{ field }}.refrash_val_arr_i64(arr)
                else
                  @{{ field }}.refrash_val_i64(value.as_i64)
                end
              elsif field_type.includes?("F64")
                if field_type.includes?("Mult")
                  arr = value.as_a.map { |item| item.as_f}
                  @{{ field }}.refrash_val_arr_f64(arr)
                else
                  @{{ field }}.refrash_val_f64(value.as_f)
                end
              end
            when 4
              # FileField
              @{{ field }}.from_path(value.as_s)
            when 5
              @{{ field }}.from_path(value.as_s)
            when 6
              # I64Field
              @{{ field }}.refrash_val_i64(value.as_i64)
            when 7
              # F64Field
              @{{ field }}.refrash_val_f64(value.as_f)
            when 8
              # BoolField
              @{{ field }}.refrash_val_bool(value.as_bool)
            when 9
              # SlugField
              @{{ field }}.refrash_val_str(value.as_s)
            else
              raise DynFork::Errors::Model::InvalidGroupNumber
                .new(@@full_model_name, {{ field.name.stringify }})
            end
          end
        end
      {% end %}
      #
      # Check and get output data.
      output_data : DynFork::Globals::OutputData = self.check(
        collection_ptr: collection_ptr,
        save?: true
      )
      #
      if output_data.valid?
        # Create doc.
        data : Hash(String, DynFork::Globals::ResultMapType) = output_data.data
        datetime : Time = Time.utc
        data["created_at"] = datetime
        data["updated_at"] = datetime
        # Run hook.
        self.pre_create
        # # Insert doc.
        collection_ptr.value.insert_one(data)
        # # Run hook.
        self.post_create
      else
        print "\nFIXTURE: ".colorize.fore(:red).mode(:bold)
        print fixture_path.colorize.fore(:blue).mode(:bold)
        self.print_err
        raise ""
      end
    end
  end
end
