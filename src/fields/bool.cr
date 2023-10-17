require "./field"

module Fields
  # Boolean field.
  class BoolField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "BoolField"
    # Field type - Html, input type.
    getter input_type : String = "checkbox"
    # Sets the value of an element.
    property value : Bool | Nil
    # Value by default.
    property default : Bool | Nil = false
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 13
  end
end
