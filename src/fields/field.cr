module Fields
  # Boolean field.
  abstract class Field
    # The value is determined automatically.
    # Format: "model-name--field-name".
    property id : String = ""
    # Web form field name.
    property label : String = ""
    # Field type - Class Name.
    property field_type : String
    # The value is determined automatically.
    property input_type : String
    # The value is determined automatically.
    property name : String = ""
    # Sets the value of an element.
    property value
    # Value by default.
    property default
    # Displays prompt text.
    property placeholder : String = ""
    # Blocks access and modification of the element.
    property is_disabled : Bool = false
    # Specifies that the field cannot be modified by the user.
    property is_readonly : Bool = false
    # Hide field from user.
    property is_hide : Bool = false
    # Example: `r# "autofocus tabindex="some number" size="some number"#`.
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
    property group : UInt32
  end
end
