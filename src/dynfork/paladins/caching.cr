# For caching Model metadata.
module DynFork::Paladins::Caching
  # Add metadata to the global store.
  private def caching
    # Get full Model name = ModuleName::StructureName.
    # <br>
    # **Examples:** _Accounts::User | Accounts::UserProfile | Cars::ElectricCar | etc ..._
    @@full_model_name = {{ @type.stringify }}
    # Get Model name = Structure name.
    # <br>
    # **Examples:** _User | UserProfile | ElectricCar | etc ..._
    # WARNING: Maximum 25 characters.
    model_name : String = @@full_model_name.split("::").last
    raise DynFork::Errors::Model::ModelNameExcessChars.new(model_name) if model_name.size > 25
    unless DynFork::Globals.cache_regex[:model_name].matches?(model_name)
      raise DynFork::Errors::Model::ModelNameRegexFails
        .new(@@full_model_name, "/^[A-Z][a-zA-Z0-9]{0,24}$/")
    end
    # Checking valid names for Model parameters.
    meta_parans = [
      "service_name",
      "fixture_name",
      "db_query_docs_limit",
      "saving_docs?",
      "updating_docs?",
      "deleting_docs?",
    ]
    {% for param in @type.annotation(DynFork::Meta).named_args %}
      unless meta_parans.includes?({{ param.stringify }})
        raise DynFork::Errors::Meta::InvalidParamName
          .new(@@full_model_name, {{ param.stringify }})
      end
    {% end %}
    # ???
    db_query_docs_limit : Int32 = {{ @type.annotation(DynFork::Meta)[:db_query_docs_limit] }} || 1000
    if db_query_docs_limit < 0
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `db_query_docs_limit` => " +
        "???."
      )
    end
    # Checking the model for the presence of variables (fields).
    {% if @type.instance_vars.size < 4 %}
      # If there are no fields in the model, a FieldsMissing exception is raise.
      raise DynFork::Errors::Model::FieldsMissing.new(@@full_model_name)
    {% end %}
    # Checking attributes for file fields.
    (
      size_name_list : Array(String) = ["xs", "sm", "md", "lg"]
      {% for var in @type.instance_vars %}
        if @{{ var }}.input_type? == "file"
          if @{{ var }}.target_dir.empty?
            raise DynFork::Errors::Panic.new(
              "Model : `#{@@full_model_name}` > Field: `#{{{ var.name.stringify }}}` > " +
              "Param: `target_dir` => An empty string is not allowed."
            )
          end
          if @{{ var }}.field_type == "ImageField"
            if thumbnails = @{{ var }}.thumbnails?
              thumbnails.each do |(size_name, max_size)|
                if !size_name_list.includes?(size_name)
                  raise DynFork::Errors::Panic.new(
                    "Model : `#{@@full_model_name}` > Field: `#{{{ var.name.stringify }}}` > " +
                    "Param: `thumbnails` => '#{size_name}' - " +
                    "Invalid thumbnail size name. Examples: xs|sm|md|lg"
                  )
                end
                if max_size < 1
                  raise DynFork::Errors::Panic.new(
                    "Model : `#{@@full_model_name}` > Field: `#{{{ var.name.stringify }}}` > " +
                    "Param: `thumbnails` => '#{max_size}' - " +
                    "The thumbnail size cannot be smaller than one pixel."
                  )
                end
              end
            end
          end
        end
      {% end %}
    )
    # Get Service name = Module name.
    # <br>
    # **Examples:** _Accounts | Smartphones | Washing machines | etc ..._
    # WARNING: Maximum 25 characters.
    service_name : String = {{ @type.annotation(DynFork::Meta)[:service_name] }} ||
      raise DynFork::Errors::Meta::ParameterMissing.new(@@full_model_name, "service_name")
    raise DynFork::Errors::Meta::ParamExcessChars
      .new(@@full_model_name, "service_name", 25) if service_name.size > 25
    unless DynFork::Globals.cache_regex[:service_name].matches?(service_name)
      raise DynFork::Errors::Meta::ParamRegexFails
        .new(@@full_model_name.gsub("::", " > "), "service_name", "/^[A-Z][a-zA-Z0-9]{0,24}$/")
    end
    # Get collection name.
    # WARNING: Maximum 50 characters.
    collection_name : String = "#{service_name}_#{model_name}"
    # Get list of names and types of variables (fields).
    # <br>
    # **Format:** _<field_name, field_type>_
    field_name_and_type_list : Hash(String, String) = (
      fields = Hash(String, String).new
      {% for var in @type.instance_vars %}
        unless @{{ var }}.ignored?
          fields[{{ var.name.stringify }}] = {{ var.type.stringify }}.split("::").last
        end
      {% end %}
      fields
    )
    # **Format:** _<field_name, <field_type, field_group>>_
    field_name_type_group_list : Hash(String, NamedTuple(type: String, group: UInt8)) = (
      fields = Hash(String, NamedTuple(type: String, group: UInt8)).new
      {% for var in @type.instance_vars %}
        unless @{{ var }}.ignored?
          fields[{{ var.name.stringify }}] = {type: {{ var.type.stringify }}.split("::").last, group: @{{ var }}.group}
        end
      {% end %}
      fields
    )
    # Get default value list.
    # <br>
    # **Format:** _<field_name, default_value>_
    default_value_list : Hash(String, DynFork::Globals::ValueTypes) = (
      # Get default value.
      fields = Hash(String, DynFork::Globals::ValueTypes).new
      {% for var in @type.instance_vars %}
        if @{{ var }}.input_type? == "file"
          if path = @{{ var }}.default?
            unless File.file?(path.to_s)
              raise DynFork::Errors::Panic.new(
                "Model : `#{@@full_model_name}` > Field: `#{{{ var.name.stringify }}}` > " +
                "Param: `default` => The file `#{path}` does not exist."
              )
            end
          end
        end
        unless @{{ var }}.ignored?
          fields[{{ var.name.stringify }}] = @{{ var }}.default?
        end
      {% end %}
      fields
    )
    # SlugField - Checking the slug_sources parameter.
    (
      one_unique_field? : Bool = false
      field_name_list : Array(String) = field_name_and_type_list.keys << "hash"
      field_type_list : Array(String) = [
        "HashField",
        "TextField",
        "EmailField",
        "DateField",
        "DateTimeField",
        "I64Field",
        "F64Field",
      ]
      {% for var in @type.instance_vars %}
        if @{{ var }}.field_type == "SlugField"
          @{{ var }}.slug_sources.each do |source_name|
            # Raise an exception if a non-existent field is specified.
            unless field_name_list.includes?(source_name)
              raise DynFork::Errors::Fields::SlugSourceNameInvalid
                .new(@@full_model_name, {{ var.name.stringify }}, source_name)
            end
            {% for var2 in @type.instance_vars %}
              if {{ var2.name.stringify }} == source_name
                # Raise an exception if source field is not allowed type.
                unless field_type_list.includes?(@{{ var2 }}.field_type)
                  raise DynFork::Errors::Fields::SlugSourceTypeInvalid
                    .new(@@full_model_name, {{ var.name.stringify }}, source_name)
                end
                # Raise an exception if sources are not required fields.
                if source_name != "hash" && !@{{ var2 }}.required?
                  raise DynFork::Errors::Fields::SlugSourceNotRequired
                    .new(@@full_model_name, {{ var.name.stringify }}, source_name)
                end
                # Is there a unique field?
                (one_unique_field? = true) if @{{ var2 }}.unique?
              end
            {% end %}
          end
          # Raise  an exception if unique fields are missing.
          unless one_unique_field?
            raise DynFork::Errors::Fields::SlugSourceNotUnique
              .new(@@full_model_name, {{ var.name.stringify }})
          end
        end
      {% end %}
    )
    # Get list of field names that will not be saved to the database.
    ignore_fields : Array(String) = (
      fields = Array(String).new
      {% for var in @type.instance_vars %}
        if @{{ var }}.ignored?
          fields << {{ var.name.stringify }}
        end
      {% end %}
      fields
    )
    # Get attributes value for fields of Model: id, name.
    field_attrs : Hash(String, NamedTuple(id: String, name: String)) = (
      fields = Hash(String, NamedTuple(id: String, name: String)).new
      {% for var in @type.instance_vars %}
        fields[{{ var.name.stringify }}] = {
          id: "#{{{ @type.name.stringify }}
            .split("::")
            .last}--#{{{ var.name.stringify }}
            .gsub("_", "-")}",
          name: {{ var.name.stringify }}
        }
      {% end %}
      fields
    )
    # Caching Time objects for date and time fields.
    time_object_list : Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)) = (
      result = Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)).new
      default_time : Time?
      max_time : Time?
      min_time : Time?
      {% for var in @type.instance_vars %}
        if @{{ var }}.field_type.includes?("Date")
          if @{{ var }}.field_type == "DateField"
            default_time = !@{{ var }}.default?.nil? ? self.date_parse(@{{ var }}.default.to_s) : nil
            max_time = !@{{ var }}.max?.nil? ? self.date_parse(@{{ var }}.max.to_s) : nil
            min_time = !@{{ var }}.min?.nil? ? self.date_parse(@{{ var }}.min.to_s) : nil
          elsif @{{ var }}.field_type == "DateTimeField"
            default_time = !@{{ var }}.default?.nil? ? self.datetime_parse(@{{ var }}.default.to_s) : nil
            max_time = !@{{ var }}.max?.nil? ? self.datetime_parse(@{{ var }}.max.to_s) : nil
            min_time = !@{{ var }}.min?.nil? ? self.datetime_parse(@{{ var }}.min.to_s) : nil
          end
          # The max date must be greater than the min date.
          if !max_time.nil? && !min_time.nil? && (max_time <=> min_time) != 1
            raise DynFork::Errors::Fields::NotCorrectMinDate
              .new(@@full_model_name, {{ var.name.stringify }})
          end
          # Check the default date against the min and max parameters.
          unless default_time.nil?
            # The default date should not exceed the maximum date.
            if !max_time.nil? && (default_time <=> max_time) == 1
              raise DynFork::Errors::Fields::NotCorrectDefaultDate
                .new(
                  @@full_model_name,
                  {{ var.name.stringify }},
                  "The default date should not exceed the max date."
                )
            end
            # The default date must not be less than the minimum date.
            if !min_time.nil? && (default_time <=> min_time) == -1
              raise DynFork::Errors::Fields::NotCorrectDefaultDate
                .new(
                  @@full_model_name,
                  {{ var.name.stringify }},
                  "The default date must not be less than the min date."
                )
            end
          end
          #
          result[{{ var.name.stringify }}] = {default: default_time, max: max_time, min: min_time}
          default_time = max_time = min_time = nil
        end
      {% end %}
      result
    )
    #
    # Add metadata to the local store.
    @@meta = {
      # Model name = Structure name.
      model_name: model_name,
      # Service Name = Application subsection = Module name.
      service_name: service_name,
      # Collection name.
      collection_name: collection_name,
      # limiting query results.
      db_query_docs_limit: {{ @type.annotation(DynFork::Meta)[:db_query_docs_limit] }} || 1000,
      # Number of variables (fields).
      field_count: {{ @type.instance_vars.size }},
      # List of names and types of variables (fields).
      # <br>
      # **Format:** _<field_name, field_type>_
      field_name_and_type_list: field_name_and_type_list,
      # **Format:** _<field_name, <field_type, field_group>>_
      field_name_type_group_list: field_name_type_group_list,
      # Default value list.
      # <br>
      # **Format:** _<field_name, default_value>_
      default_value_list: default_value_list,
      # Create documents in the database. By default = true.
      # NOTE: false - Alternatively, use it to validate data from web forms.
      saving_docs?: if !(val = {{ @type.annotation(DynFork::Meta)[:saving_docs?] }}).nil?
        val
      else
        true
      end,
      # Update documents in the database.
      updating_docs?: if !(val = {{ @type.annotation(DynFork::Meta)[:updating_docs?] }}).nil?
        val
      else
        true
      end,
      # Delete documents from the database.
      deleting_docs?: if !(val = {{ @type.annotation(DynFork::Meta)[:deleting_docs?] }}).nil?
        val
      else
        true
      end,
      # List of field names that will not be saved to the database.
      ignore_fields: ignore_fields,
      # Attributes value for fields of Model: id, name.
      field_attrs: field_attrs,
      # Data for dynamic fields.
      # <br>
      # **Format:** _<field_name, json>_
      data_dynamic_fields: Hash(String, String).new,
      # Caching Time objects for date and time fields.
      time_object_list: time_object_list,
      # The name of the fixture in the 'config/fixtures' directory (without extension).
      fixture_name: {{ @type.annotation(DynFork::Meta)[:fixture_name] }},
    }
  end
end
