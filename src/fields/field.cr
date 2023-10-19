require "json"

module Fields
  # Boolean field.
  abstract struct Field
    include JSON::Serializable
    # The value is determined automatically.
    # Format: "model-name--field-name".
    property id : String = ""
    # Web form field name.
    property label : String = ""
    # Field type - Class Name.
    getter field_type : String = ""
    # The value is determined automatically.
    property name : String = ""
    # Sets the value of an element.
    property value
    # Required field.
    property is_required : Bool = false
    # Blocks access and modification of the element.
    property is_disabled : Bool = false
    # Specifies that the field cannot be modified by the user.
    property is_readonly : Bool = false
    # Hide field from user.
    property is_hide : Bool = false
    # Example: %(autofocus tabindex="some number" size="some number").
    property other_attrs : String = ""
    # Example: "class-name-1 class-name-2".
    property css_classes : String = ""
    # Additional explanation for the user.
    property hint : String = ""
    # Warning information.
    property warning : String = ""
    # The value is determined automatically.
    property errors : Array(String) = Array(String).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 0
  end
end
