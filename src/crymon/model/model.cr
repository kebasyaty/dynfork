require "json"

module Crymon
  # For define metadata in models.
  annotation Metadata; end

  # Abstraction for converting Crystal structures into Crymon Models.
  abstract struct Model
    include JSON::Serializable
    include JSON::Serializable::Strict

    def initialize; end

    # Model name (Structure name).
    def model_name : String
      {{ @type.name.stringify }}.split("::").last
    end

    # Get model key.
    # Hint: To access data in the cache.
    def model_key : String
      service_name : String = {{ @type.annotation(Crymon::Metadata)["service_name"] }}.strip
      unique_app_key : String = {{ @type.annotation(Crymon::Metadata)["unique_app_key"] }}.strip
      "#{service_name}_#{self.model_name}_#{unique_app_key}"
    end

    # Number of variables (fields).
    def vars_count : Int32
      {{ @type.instance_vars.size }}
    end

    # List of variable (field) names.
    def instance_vars_names : Array(String)
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.name.stringify }}
      {% else %}
        Array(String).new
      {% end %}
    end

    # List is a list of variable (field) types.
    def instance_vars_types : Array(String)
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.type.stringify }}
          .map { |name| name.split("::").last }
      {% else %}
        Array(String).new
      {% end %}
    end

    # List of names and types of variables (fields).
    # Format: <field_name, field_type>
    def instance_vars_name_and_type : Hash(String, String)
      {% if @type.instance_vars.size > 0 %}
        Hash.zip(
          {{ @type.instance_vars.map &.name.stringify }},
          {{ @type.instance_vars.map &.type.stringify }}
            .map { |name| name.split("::").last }
        )
      {% else %}
        Hash(String, String).new
      {% end %}
    end

    # Determine the presence of a variable (field) in the model.
    def has_instance_var?(name) : Bool
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.name.stringify }}.includes? name
      {% else %}
        false
      {% end %}
    end

    # Metadata for the Model.
    def meta : NamedTuple(
      "app_name": String,
      "unique_app_key": String,
      "service_name": String,
      "database_name": String,
      "collection_name": String,
      "db_query_docs_limit": UInt32,
      "is_add_doc": Bool,
      "is_up_doc": Bool,
      "is_del_doc": Bool,
      "is_use_addition": Bool,
      "is_use_hooks": Bool,
      "is_use_hash_slug": Bool,
      "ignore_fields": Array(String))
      #
      app_name : String = {{ @type.annotation(Crymon::Metadata)["app_name"] }}.strip
      unique_app_key : String = {{ @type.annotation(Crymon::Metadata)["unique_app_key"] }}.strip
      service_name : String = {{ @type.annotation(Crymon::Metadata)["service_name"] }}.strip
      database_name : String = {{ @type.annotation(Crymon::Metadata)["database_name"] }}.strip
      {
        "app_name":            app_name,
        "unique_app_key":      unique_app_key,
        "service_name":        service_name,
        "database_name":       "#{app_name}_#{database_name}_#{unique_app_key}",
        "collection_name":     "#{service_name}_#{self.model_name}",
        "db_query_docs_limit": {{ @type.annotation(Crymon::Metadata)["db_query_docs_limit"] }} || 1000_u32,
        "is_add_doc":          {{ @type.annotation(Crymon::Metadata)["is_add_doc"] }} || true,
        "is_up_doc":           {{ @type.annotation(Crymon::Metadata)["is_up_doc"] }} || true,
        "is_del_doc":          {{ @type.annotation(Crymon::Metadata)["is_del_doc"] }} || true,
        "is_use_addition":     {{ @type.annotation(Crymon::Metadata)["is_use_addition"] }} || false,
        "is_use_hooks":        {{ @type.annotation(Crymon::Metadata)["is_use_hooks"] }} || false,
        "is_use_hash_slug":    {{ @type.annotation(Crymon::Metadata)["is_use_hash_slug"] }} || false,
        # List of field names that will not be saved to the database.
        "ignore_fields": ({{ @type.annotation(Crymon::Metadata)["ignore_fields"] }} || Array(String).new).map { |name| name.strip },
      }
    end
  end
end
