# For caching Model metadata.
module DynFork::Paladins::Caching
  # Add metadata to the global store.
  private def caching : Nil
    # Get full Model name = ModuleName::StructureName.
    # <br>
    # **Examples:** _Accounts::User | Accounts::UserProfile | Cars::ElectricCar | etc ..._
    @@full_model_name = {{ @type.stringify }}
    # Checking the Model for missing fields
    {% if @type.instance_vars.size < 4 %}
      # If there are no fields in the model, a FieldsMissing exception is raise.
      raise DynFork::Errors::Model::FieldsMissing.new(@@full_model_name)
    {% end %}
    # Get Model name = Structure name.
    # <br>
    # **Examples:** _User | UserProfile | ElectricCar | etc ..._
    # WARNING: Maximum 25 characters.
    model_name : String = @@full_model_name.split("::").last
    raise DynFork::Errors::Model::ModelNameExcessChars.new(model_name) if model_name.size > 25
    unless DynFork::Globals.regex[:model_name].matches?(model_name)
      raise DynFork::Errors::Model::ModelNameRegexFails
        .new(@@full_model_name, "/^[A-Z][a-zA-Z0-9]{0,24}$/")
    end
    # Checking valid names for Model parameters.
    meta_parans = [
      "service_name",
      "fixture_name",
      "db_query_docs_limit",
      "migrat_model?",
      "create_doc?",
      "update_doc?",
      "delete_doc?",
    ]
    {% for param in @type.annotation(DynFork::Meta).named_args %}
      unless meta_parans.includes?({{ param.stringify }})
        raise DynFork::Errors::Meta::InvalidParamName
          .new(@@full_model_name, {{ param.stringify }})
      end
    {% end %}
    # Get the parameter and check for an empty value.
    fixture_name : String? = {{ @type.annotation(DynFork::Meta)[:fixture_name] }}
    if !fixture_name.nil? && fixture_name.presence.nil?
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `fixture_name` => " +
        "The parameter contains an empty value."
      )
    end
    # Check the presence of the fixture file.
    if !fixture_name.nil? && !File.file?("config/fixtures/#{fixture_name}.yml")
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `fixture_name` => " +
        "The `#{fixture_name}` fixture is missing in the `config/fixtures` directory!"
      )
    end
    # Checking a parameter for an unsigned value.
    db_query_docs_limit : Int32 = {{ @type.annotation(DynFork::Meta)[:db_query_docs_limit] }} || 1000
    if db_query_docs_limit < 0
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `db_query_docs_limit` => " +
        "The value must not be less than zero."
      )
    end
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
    #
    # Checking attributes for file fields.
    {% for var in @type.instance_vars %}
      if !@{{ var }}.ignored? &&
        @{{ var }}.field_type.includes?("Choice") &&
          !@{{ var }}.field_type.includes?("Dyn")
        #
        if @{{ var }}.choices.nil?
          msg = "Field type: `#{@{{ var }}.field_type}` => " +
                "The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
      end
    {% end %}
    #
    # Get Service name = Module name.
    # <br>
    # **Examples:** _Accounts | Smartphones | Washing machines | etc ..._
    # WARNING: Maximum 25 characters.
    service_name : String = {{ @type.annotation(DynFork::Meta)[:service_name] }} ||
      raise DynFork::Errors::Meta::ParameterMissing.new(@@full_model_name, "service_name")
    raise DynFork::Errors::Meta::ParamExcessChars
      .new(@@full_model_name, "service_name", 25) if service_name.size > 25
    unless DynFork::Globals.regex[:service_name].matches?(service_name)
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
    field_name_params_list : Hash(String, NamedTuple(type: String, group: UInt8)) = (
      fields = Hash(String, NamedTuple(type: String, group: UInt8)).new
      {% for var in @type.instance_vars %}
        unless @{{ var }}.ignored?
          fields[{{ var.name.stringify }}] = {type: {{ var.type.stringify }}.split("::").last, group: @{{ var }}.group}
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
    # Data for dynamic fields.
    # <br>
    # **Format:** _<field_name, data_json>_
    data_dynamic_fields : Hash(String, String) = (
      dyn_fields = Hash(String, String).new
      {% for var in @type.instance_vars %}
        if !@{{ var }}.ignored? && @{{ var }}.field_type.includes?("Dyn")
          dyn_fields[{{ var.name.stringify }}] = "[]"
        end
      {% end %}
      dyn_fields
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
      db_query_docs_limit: db_query_docs_limit,
      # Number of variables (fields).
      field_count: {{ @type.instance_vars.size }},
      # List of names and types of variables (fields).
      # <br>
      # **Format:** _<field_name, field_type>_
      field_name_and_type_list: field_name_and_type_list,
      # **Format:** _<field_name, <field_type, field_group>>_
      field_name_params_list: field_name_params_list,
      # Set to **true** if you do not need to import the Model into the database.<br>
      # This can be use to validate a web forms - Search form, Contact form, etc.
      migrat_model?: if !(val = {{ @type.annotation(DynFork::Meta)[:migrat_model?] }}).nil?
        val
      else
        true
      end,
      # Can a Model create new documents in a collection?
      create_doc?: if !(val = {{ @type.annotation(DynFork::Meta)[:create_doc?] }}).nil?
        val
      else
        true
      end,
      # Can a Model update documents in a collection?
      update_doc?: if !(val = {{ @type.annotation(DynFork::Meta)[:update_doc?] }}).nil?
        val
      else
        true
      end,
      # Can a Model remove documents from a collection?
      delete_doc?: if !(val = {{ @type.annotation(DynFork::Meta)[:delete_doc?] }}).nil?
        val
      else
        true
      end,
      # Attributes value for fields of Model: id, name.
      field_attrs: field_attrs,
      # Data for dynamic fields.
      # <br>
      # **Format:** _<field_name, data_json>_
      data_dynamic_fields: data_dynamic_fields,
      # Caching Time objects for date and time fields.
      time_object_list: time_object_list,
      # The name of the fixture in the 'config/fixtures' directory (without extension).
      fixture_name: fixture_name,
    }
  end
end
