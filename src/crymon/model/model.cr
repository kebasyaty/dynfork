require "json"

module Crymon
  # For define metadata in models.
  annotation Meta; end

  # Abstraction for converting Crystal structures into Crymon Models.
  abstract struct Model
    include JSON::Serializable
    include JSON::Serializable::Strict

    getter hash = Crymon::Fields::HashField.new
    getter created_at = Crymon::Fields::DateTimeField.new("label": "Created at", "is_hide": true)
    getter updated_at = Crymon::Fields::DateTimeField.new("label": "Updated at", "is_hide": true)

    def initialize
      self.caching
      self.extra
    end

    # Additional initialization.
    def extra
      model_key : String = self.model_key
      var_name : String | Nil
      # Injection of metadata from storage.
      {% for var in @type.instance_vars %}
        var_name = {{ var.name.stringify }}
        @{{ var }}.id = Crymon::Globals.store[model_key][:field_attrs][var_name][:id]
        @{{ var }}.name = Crymon::Globals.store[model_key][:field_attrs][var_name][:name]
      {% end %}
    end

    # Get model key.
    # NOTE: To access data in the cache.
    def model_key : String
      model_name : String = {{ @type.name.stringify }}.split("::").last
      service_name : String = {{ @type.annotation(Crymon::Meta)[:service_name] }} ||
        raise Crymon::Errors::MetaParameterMissing.new(model_name, "service_name")
      "#{service_name}_#{model_name}"
    end

    # Determine the presence of a variable (field) in the model.
    def []?(variable) : Bool
      {% for var in @type.instance_vars %}
        if {{ var.name.stringify }} == variable
          return true
        end
      {% end %}
      false
    end

    # Get a list of field names and their values.
    def field_name_and_value_list : Hash(String, Crymon::Globals::FieldTypes)
      fields = Hash(String, Crymon::Globals::FieldTypes).new
      {% for var in @type.instance_vars %}
        fields[{{ var.name.stringify }}] = @{{ var }}
      {% end %}
      fields
    end

    # Add metadata to the global store.
    def caching
      # Get model key.
      model_key : String = self.model_key
      # Run caching.
      if Crymon::Globals.store[model_key]?.nil?
        {% if @type.instance_vars.size < 4 %}
          # If there are no fields in the model, a FieldsMissing exception is raise.
          raise Crymon::Errors::ModelFieldsMissing.new({{ @type.name.stringify }}.split("::").last)
        {% end %}
        # Model name = Structure name.
        # WARNING: Maximum 25 characters.
        # NOTE: Examples: electric_car_store | electric-car-store | Electric-Car_Store | ElectricCarStore
        model_name : String = {{ @type.name.stringify }}.split("::").last
        raise Crymon::Errors::ModelNameExcessCharacters.new(model_name) if model_name.size > 25
        unless /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?(model_name)
          raise Crymon::Errors::ModelNameRegexFails.new(model_name, "/^[A-Z][a-zA-Z0-9]{0,24}$/")
        end
        # Project name.
        # WARNING: Maximum 44 characters.
        app_name : String = {{ @type.annotation(Crymon::Meta)[:app_name] }} ||
          raise Crymon::Errors::MetaParameterMissing.new(model_name, "app_name")
        raise Crymon::Errors::MetaParamExcessCharacters.new(model_name, "app_name", 44) if app_name.size > 44
        unless /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?(app_name)
          raise Crymon::Errors::MetaParamRegexFails.new(model_name, "app_name", "/^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/")
        end
        # Unique project key.
        unique_app_key : String = {{ @type.annotation(Crymon::Meta)[:unique_app_key] }} ||
          raise Crymon::Errors::MetaParameterMissing.new(model_name, "unique_app_key")
        unless /^[a-zA-Z0-9]{16}$/.matches?(unique_app_key)
          raise Crymon::Errors::MetaParamRegexFails.new(model_name, "unique_app_key", "/^[a-zA-Z0-9]{16}$/")
        end
        # Service Name = Application subsection = Module name.
        # WARNING: Maximum 25 characters.
        # NOTE: Examples: AutoParts | Autoparts | AutoParts360
        service_name : String = {{ @type.annotation(Crymon::Meta)[:service_name] }} ||
          raise Crymon::Errors::MetaParameterMissing.new(model_name, "service_name")
        raise Crymon::Errors::MetaParamExcessCharacters.new(model_name, "service_name", 25) if service_name.size > 25
        unless /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?(service_name)
          raise Crymon::Errors::MetaParamRegexFails.new(model_name, "service_name", "/^[A-Z][a-zA-Z0-9]{0,24}$/")
        end
        # Database name.
        # WARNING: Maximum 60 characters.
        database_name : String = "#{app_name}_#{unique_app_key}"
        # Collection name.
        # WARNING: Maximum 50 characters.
        collection_name : String = "#{service_name}_#{model_name}"
        # List of variable (field) names.
        field_name_list : Array(String) = (
          {% if @type.instance_vars.size > 3 %}
            {{ @type.instance_vars.map &.name.stringify }}
          {% else %}
            Array(String).new
          {% end %}
        )
        # List is a list of variable (field) types.
        field_type_list : Array(String) = (
          {% if @type.instance_vars.size > 3 %}
            {{ @type.instance_vars.map &.type.stringify }}
              .map { |name| name.split("::").last }
          {% else %}
            Array(String).new
          {% end %}
        )
        # List of names and types of variables (fields).
        # NOTE: Format: <field_name, field_type>
        field_name_and_type_list : Hash(String, String) = (
          {% if @type.instance_vars.size > 3 %}
            Hash.zip(
              {{ @type.instance_vars.map &.name.stringify }},
              {{ @type.instance_vars.map &.type.stringify }}
                .map { |name| name.split("::").last }
            )
          {% else %}
            Hash(String, String).new
          {% end %}
        )
        # Default value list.
        # NOTE: Format: <field_name, default_value>
        default_value_list : Hash(String, Crymon::Globals::ValueTypes) = (
          {% if @type.instance_vars.size > 3 %}
            hash = Hash(String, Crymon::Globals::ValueTypes).new
            self.field_name_and_value_list.each do |key, value|
              hash[key] = value.default
            end
            hash
          {% else %}
            Hash(String, Crymon::Globals::ValueTypes).new
          {% end %}
        )
        # List of field names that will not be saved to the database.
        ignore_fields : Array(String) = {{ @type.annotation(Crymon::Meta)[:ignore_fields] }} ||
          Array(String).new
        ignore_fields.each do |field_name|
          unless field_name_list.includes?(field_name)
            raise Crymon::Errors::MetaIgnoredFieldMissing.new(model_name, "ignore_fields", field_name)
          end
        end
        # Attributes value for fields of Model: id, name.
        field_attrs : Hash(String, NamedTuple(id: String, name: String)) = (
          hash = Hash(String, NamedTuple(id: String, name: String)).new
          {% if @type.instance_vars.size > 3 %}
            {% for var in @type.instance_vars %}
              hash[{{ var.name.stringify }}] = {
                id: "#{{{ @type.name.stringify }}.split("::").last}--#{{{ var.name.stringify }}.gsub("_", "-")}",
                name: {{ var.name.stringify }}
              }
            {% end %}
          {% end %}
          hash
        )
        #
        # Add metadata to the global store.
        Crymon::Globals.store[model_key] = {
          # Project name.
          app_name: app_name,
          # Model name = Structure name.
          model_name: model_name,
          # Unique project key.
          unique_app_key: unique_app_key,
          # Service Name - Application subsection.
          service_name: service_name,
          # Database name.
          database_name: database_name,
          # Collection name.
          collection_name: collection_name,
          # limiting query results.
          db_query_docs_limit: {{ @type.annotation(Crymon::Meta)[:db_query_docs_limit] }} || 1000_u32,
          # Number of variables (fields).
          field_count: {{ @type.instance_vars.size }},
          # List of variable (field) names.
          field_name_list: field_name_list,
          # List is a list of variable (field) types.
          field_type_list: field_type_list,
          # List of names and types of variables (fields).
          # NOTE: Format: <field_name, field_type>
          field_name_and_type_list: field_name_and_type_list,
          # Default value list.
          # NOTE: Format: <field_name, default_value>
          default_value_list: default_value_list,
          # Create documents in the database. By default = true.
          # NOTE: false - Alternatively, use it to validate data from web forms.
          is_add_doc: {{ @type.annotation(Crymon::Meta)[:is_add_doc] }} || true,
          # Update documents in the database.
          is_up_doc: {{ @type.annotation(Crymon::Meta)[:is_up_doc] }} || true,
          # Delete documents from the database.
          is_del_doc: {{ @type.annotation(Crymon::Meta)[:is_del_doc] }} || true,
          # Allows methods for additional actions and additional validation.
          is_use_addition: {{ @type.annotation(Crymon::Meta)[:is_use_addition] }} || false,
          # Allows hooks methods - impl Hooks for ModelName.
          is_use_hooks: {{ @type.annotation(Crymon::Meta)[:is_use_hooks] }} || false,
          # Is the hash field used for the slug?
          is_use_hash_slug: {{ @type.annotation(Crymon::Meta)[:is_use_hash_slug] }} || false,
          # List of field names that will not be saved to the database.
          ignore_fields: ignore_fields,
          # Attributes value for fields of Model: id, name.
          field_attrs: field_attrs,
        }
      end
    end
  end
end
