require "./field"

module Fields
  # A field for entering a date и времени in the format yyyy-mm-ddThh:mm.
  # Example: 1970-01-01T00:00
  class DateTimeField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "DateTimeField"
    # Html tag: input type="date".
    getter input_type : String = "datetime"
    # Sets the value of an element.
    # Example: 1970-01-01T00:00
    property value : String | Nil
    # Value by default.
    # Example: 1970-01-01T00:00
    property default : String | Nil
    # Displays prompt text.
    property placeholder : String = ""
    # The top value for entering a date and time.
    property max : String = ""
    # The lower value for entering a date and time.
    property min : String = ""
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Additional explanation for the user.
    property hint : String = "Format: yyyy-mm-ddThh:mm"
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 3
  end
end
