require "./field"

module Fields
  # Type of selective field with static of elements.
  # With a single choice.
  class ChoiceTextField < Fields::Field
    # Field type - Class Name.
    getter field_type : String = "ChoiceTextField"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # Specifies that multiple options can be selected at once.
    getter multiple : Bool = false
    # Displays prompt text.
    property placeholder : String = ""
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    #
    property choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 4
  end
end
