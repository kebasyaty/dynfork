require "json"

module Crymon
  # For define metadata in models.
  annotation Metadata; end

  # Abstraction for converting Crystal structures into Crymon Models.
  abstract struct Model
    include JSON::Serializable
    include JSON::Serializable::Strict

    def initialize
      self.run
    end

    # ???
    def run
      {% unless @type.instance_vars.empty? %}
        {% for var in @type.instance_vars %}
          @{{ var }}.id = "#{{{ @type.name.stringify }}.split("::").last}--#{{{ var.name.stringify }}}"
          @{{ var }}.name = {{ var.name.stringify }}
        {% end %}
      {% else %}
        # If there are no fields in the model, a FieldsMissing exception is raise.
        raise Crymon::Errors::FieldsMissing.new({{ @type.name.stringify }}.split("::").last)
      {% end %}
    end

    # Get model key.
    # NOTE: To access data in the cache.
    def model_key : String
      model_name : String = {{ @type.name.stringify }}.split("::").last
      service_name : String = {{ @type.annotation(Crymon::Metadata)["service_name"] }}
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

    # Metadata for the Model.
    def meta : NamedTuple(
      "app_name": String,
      "model_name": String,
      "unique_app_key": String,
      "service_name": String,
      "database_name": String,
      "collection_name": String,
      "db_query_docs_limit": UInt32,
      "field_count": Int32,
      "field_name_list": Array(String),
      "field_type_list": Array(String),
      "field_name_and_type_list": Hash(String, String),
      "default_value_list": Hash(String, Crymon::Globals::ValueTypes),
      "is_add_doc": Bool,
      "is_up_doc": Bool,
      "is_del_doc": Bool,
      "is_use_addition": Bool,
      "is_use_hooks": Bool,
      "is_use_hash_slug": Bool,
      "ignore_fields": Array(String))
      #
      # Project name.
      app_name : String = {{ @type.annotation(Crymon::Metadata)["app_name"] }} ||
        raise Crymon::Errors::ParameterMissing.new("app_name")
      # Model name = Structure name.
      model_name : String = {{ @type.name.stringify }}.split("::").last
      # Unique project key.
      unique_app_key : String = {{ @type.annotation(Crymon::Metadata)["unique_app_key"] }} ||
        raise Crymon::Errors::ParameterMissing.new("unique_app_key")
      # Service Name - Application subsection.
      service_name : String = {{ @type.annotation(Crymon::Metadata)["service_name"] }} ||
        raise Crymon::Errors::ParameterMissing.new("service_name")
      # List of variable (field) names.
      field_name_list : Array(String) = (
        {% unless @type.instance_vars.empty? %}
          {{ @type.instance_vars.map &.name.stringify }}
        {% else %}
          Array(String).new
        {% end %}
      )
      # List of field names that will not be saved to the database.
      ignore_fields : Array(String) = {{ @type.annotation(Crymon::Metadata)["ignore_fields"] }} ||
        Array(String).new
      ignore_fields.each do |field_name|
        unless field_name_list.includes?(field_name)
          raise Crymon::Errors::IgnoredFieldMissing.new(field_name)
        end
      end
      # List is a list of variable (field) types.
      field_type_list : Array(String) = (
        {% unless @type.instance_vars.empty? %}
          {{ @type.instance_vars.map &.type.stringify }}
            .map { |name| name.split("::").last }
        {% else %}
          Array(String).new
        {% end %}
      )
      # List of names and types of variables (fields).
      # NOTE: Format: <field_name, field_type>
      field_name_and_type_list : Hash(String, String) = (
        {% unless @type.instance_vars.empty? %}
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
        {% unless @type.instance_vars.empty? %}
          hash = Hash(String, Crymon::Globals::ValueTypes).new
          self.field_name_and_value_list.each do |key, value|
            hash[key] = value.default
          end
          hash
        {% else %}
          Hash(String, Crymon::Globals::ValueTypes).new
        {% end %}
      )
      #
      {
        # Project name.
        "app_name": app_name,
        # Model name = Structure name.
        "model_name": model_name,
        # Unique project key.
        "unique_app_key": unique_app_key,
        # Service Name - Application subsection.
        "service_name": service_name,
        # Database name.
        "database_name": "#{app_name}_#{unique_app_key}",
        # Collection name.
        "collection_name": "#{service_name}_#{model_name}",
        # limiting query results.
        "db_query_docs_limit": {{ @type.annotation(Crymon::Metadata)["db_query_docs_limit"] }} || 1000_u32,
        # Number of variables (fields).
        "field_count": {{ @type.instance_vars.size }},
        # List of variable (field) names.
        "field_name_list": field_name_list,
        # List is a list of variable (field) types.
        field_type_list: field_type_list,
        # List of names and types of variables (fields).
        # NOTE: Format: <field_name, field_type>
        "field_name_and_type_list": field_name_and_type_list,
        # Default value list.
        # NOTE: Format: <field_name, default_value>
        "default_value_list": default_value_list,
        # Create documents in the database. By default = true.
        # NOTE: false - Alternatively, use it to validate data from web forms.
        "is_add_doc": {{ @type.annotation(Crymon::Metadata)["is_add_doc"] }} || true,
        # Update documents in the database.
        "is_up_doc": {{ @type.annotation(Crymon::Metadata)["is_up_doc"] }} || true,
        # Delete documents from the database.
        "is_del_doc": {{ @type.annotation(Crymon::Metadata)["is_del_doc"] }} || true,
        # Allows methods for additional actions and additional validation.
        "is_use_addition": {{ @type.annotation(Crymon::Metadata)["is_use_addition"] }} || false,
        # Allows hooks methods - impl Hooks for ModelName.
        "is_use_hooks": {{ @type.annotation(Crymon::Metadata)["is_use_hooks"] }} || false,
        # Is the hash field used for the slug?
        "is_use_hash_slug": {{ @type.annotation(Crymon::Metadata)["is_use_hash_slug"] }} || false,
        # List of field names that will not be saved to the database.
        "ignore_fields": ignore_fields,
      }
    end
  end
end
