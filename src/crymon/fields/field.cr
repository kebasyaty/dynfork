require "bson"
require "json"

module Crymon::Fields
  # An abstract structure with common fields for all field types.
  @[JSON::Serializable::Options(emit_nulls: true)]
  abstract struct Field
    include JSON::Serializable
    include JSON::Serializable::Strict
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
    getter is_required : Bool = false
    # Blocks access and modification of the element.
    property is_disabled : Bool = false
    # Specifies that the field cannot be modified by the user.
    property is_readonly : Bool = false
    # Hide field from user.
    property is_hide : Bool = false
    # If true, the value of this field is not saved in the database.
    getter is_ignored : Bool = false
    # _Example: %(autofocus tabindex="some number" size="some number")_
    getter other_attrs : String = ""
    # _Example: "class-name-1 class-name-2"_
    getter css_classes : String = ""
    # Additional explanation for the user.
    getter hint : String = ""
    # Warning information.
    property warning : String = ""
    # WARNING: The value is determined automatically.
    property errors : Array(String) = Array(String).new
    # To optimize field traversal in the `check` method.
    # WARNING: It is recommended not to change.
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

    # To work around the error - undefined method 'choices='.
    # WARNING: Stub
    def set_choices(json : String); end

    # To work around the error - undefined method 'slug_sources='.
    # WARNING: Stub
    def get_slug_sources : Array(String)
      Array(String).new
    end
  end
end
