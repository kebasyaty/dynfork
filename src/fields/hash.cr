require "./field"

module Fields
  # This type was created specifically for the hash field.
  struct HashField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "HashField"
    # Html tag: input type="url".
    getter input_type : String = "text"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # Displays prompt text.
    property placeholder : String = ""
    # The maximum number of characters allowed in the text.
    property maxlength : UInt32 = 12
    # The minimum number of characters allowed in the text.
    property minlength : UInt32 = 12
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Hide field from user.
    property is_hide : Bool = true
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 1
  end
end
