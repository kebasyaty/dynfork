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
        @{{ field }}.value = nil
        unless @{{ field }}.ignored?
          unless (value = yaml[@{{ field }}.name]?).nil?
            field_type = @{{ field }}.field_type
            case @{{ field }}.group
            when 1
              # ColorField | EmailField | PasswordField | PhoneField
              # | TextField | HashField | URLField | IPField
              if !(val = value.as_s?).nil?
                @{{ field }}.refrash_val_str(val)
              end
            when 2
              # DateField | DateTimeField
              if field_type.includes?("Time")
                if !(val = value.as_s?).nil?
                  dt = self.datetime_parse(val)
                  @{{ field }}.refrash_val_datetime(dt)
                end
              else
                if !(val = value.as_s?).nil?
                  dt = self.date_parse(val)
                  @{{ field }}.refrash_val_date(dt)
                end
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
                  if !(val = value.as_a?).nil?
                    arr = val.map { |item| item.as_s}
                    @{{ field }}.refrash_val_arr_str(arr)
                  end
                else
                  if !(val = value.as_s?).nil?
                    @{{ field }}.refrash_val_str(val)
                  end
                end
              elsif field_type.includes?("I64")
                if field_type.includes?("Mult")
                  if !(val = value.as_a?).nil?
                    arr = val.map { |item| item.as_i64}
                    @{{ field }}.refrash_val_arr_i64(arr)
                  end
                else
                  if !(val = value.as_i64?).nil?
                    @{{ field }}.refrash_val_i64(val)
                  end
                end
              elsif field_type.includes?("F64")
                if field_type.includes?("Mult")
                  if !(val = value.as_s?).nil?
                    arr = val.map { |item| item.as_f}
                    @{{ field }}.refrash_val_arr_f64(arr)
                  end
                else
                  if !(val = value.as_f?).nil?
                    @{{ field }}.refrash_val_f64(val)
                  end
                end
              end
            when 4
              # FileField
              if !(val = value.as_s?).nil?
                @{{ field }}.from_path(val)
              end
            when 5
              if !(val = value.as_s?).nil?
                @{{ field }}.from_path(val)
              end
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
              if !(val = value.as_s?).nil?
                @{{ field }}.refrash_val_str(val)
              end
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
