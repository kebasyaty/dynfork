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
    # The minimum number of characters allowed in the text.
    property minlength : UInt32 = 0
    # The maximum number of characters allowed in the text.
    property maxlength : UInt32 = 256
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    #
    choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 4
  end
end
