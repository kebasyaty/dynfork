module Crymon
  # ???
  abstract struct Model
    # ???
    def model_name : String
      {{ @type.stringify }}.split("::")[-1]
    end

    # ???
    def fields_count : Int32
      {{ @type.instance_vars.size }}
    end

    # ???
    def instance_vars_names : Array(String)
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.name.stringify }}
      {% else %}
        Array(String).new
      {% end %}
    end

    # ???
    def instance_vars_types : Array(String)
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.type.stringify }}
      {% else %}
        Array(String).new
      {% end %}
    end

    # ???
    # Format: <field_name, field_type>
    def instance_vars_name_and_type : Hash(String, String)
      {% if @type.instance_vars.size > 0 %}
        Hash.zip(
          {{ @type.instance_vars.map &.name.stringify }},
          {{ @type.instance_vars.map &.type.stringify }}
        )
      {% else %}
        Hash(String, String).new
      {% end %}
    end

    # ???
    def has_instance_var?(name) : Bool
      {% if @type.instance_vars.size > 0 %}
        {{ @type.instance_vars.map &.name.stringify }}.includes? name
      {% else %}
        false
      {% end %}
    end
  end
end
