require "./field"

module Fields
  # Field for entering URL addresses.
  class URLField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "URLField"
    # The value is determined automatically.
    getter input_type : String = "url"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # The minimum number of characters allowed in the text.
    property minlength : UInt32 = 0
    # The maximum number of characters allowed in the text.
    property maxlength : UInt32 = 256
    # Mandatory field.
    property is_required : Bool = false
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 1
  end
end
