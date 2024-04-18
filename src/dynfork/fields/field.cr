module DynFork::Fields
  # An abstract structure with common fields for all field types.
  @[JSON::Serializable::Options(emit_nulls: true)]
  abstract struct Field
    include JSON::Serializable
    # *Format: "ModelName--field-name"*
    # WARNING: The value is determined automatically.
    property id : String = ""
    # Text label for a web form field.
    getter label : String = ""
    # Field name.
    # WARNING: The value is determined automatically.
    property name : String = ""
    # Field type - Structure Name.
    getter field_type : String = ""
    # Required field.
    getter? required : Bool = false
    # Blocks access and modification of the element.
    property? disabled : Bool = false
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool = false
    # Hide field from user.
    property? hide : Bool = false
    # If true, the value of this field is not saved in the database.
    getter? ignored : Bool = false
    # Additional explanation for the user.
    getter hint : String = ""
    # Warning information.
    property warning : String = ""
    # WARNING: The value is determined automatically.
    property errors : Array(String) = Array(String).new
    # To optimize field traversal in the `check` method.
    # WARNING: It is recommended not to change.
    @[JSON::Field(ignore: true)]
    getter group : UInt8 = 0

    # Determine the presence of a variable (attribute) in the Field type.
    def []?(variable) : Bool
      {% for var in @type.instance_vars %}
          if {{ var.name.stringify }} == variable
              return true
          end
        {% end %}
      false
    end

    def choices_from_json(json : String) : Void; end

    def slug_sources : Array(String)
      Array(String).new
    end
  end
end
