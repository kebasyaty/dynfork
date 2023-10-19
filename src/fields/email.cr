require "./field"

module Fields
  # Field for entering Email addresses.
  struct EmailField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "EmailField"
    # Html tag: input type="url".
    getter input_type : String = "email"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # Displays prompt text.
    property placeholder : String = ""
    # The maximum number of characters allowed in the text.
    property maxlength : UInt32 = 320
    # The minimum number of characters allowed in the text.
    property minlength : UInt32 = 0
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 1
  end
end
