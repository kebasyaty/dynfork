require "./field"

module Fields
  # A field for entering a date in the format yyyy-mm-dd.
  # Example: 1970-01-01
  struct DateField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "DateField"
    # Html tag: input type="date".
    getter input_type : String = "date"
    # Sets the value of an element.
    # Example: 1970-01-01
    property value : String | Nil
    # Value by default.
    # Example: 1970-01-01
    property default : String | Nil
    # Displays prompt text.
    property placeholder : String = ""
    # The top value for entering a date.
    property max : String = ""
    # The lower value for entering a date.
    property min : String = ""
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Additional explanation for the user.
    property hint : String = "Format: yyyy-mm-dd"
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 3
  end
end
