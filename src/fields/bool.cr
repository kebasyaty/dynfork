require "./field"

module Fields
  # Boolean field.
  class BoolField < Fields::Field
    # Field type - Class Name.
    property field_type : String = "BoolField"
    # The value is determined automatically.
    property input_type : String = "checkbox"
    # Sets the value of an element.
    property value : Bool | Nil
    # Value by default.
    property default : Bool | Nil = false
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    property group : UInt32 = 13
  end
end
