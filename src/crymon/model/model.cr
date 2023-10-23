module Crymon
  # Abstraction for converting Crystal structures into Crymon Models.
  abstract struct Model
    # Model name (Structure name).
    def model_name : String
      {{ @type.name.stringify }}.split("::")[-1]
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
          .map { |name| name.split("::")[-1] }
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
            .map { |name| name.split("::")[-1] }
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
  end
end
