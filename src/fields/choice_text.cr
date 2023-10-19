require "./field"

module Fields
  # Type of selective field with static of elements.
  # With a single choice.
  struct ChoiceTextField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextField"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 4
  end

  # Type of selective field with static of elements.
  # With multiple choice.
  struct ChoiceTextMultField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultField"
    # Sets the value of an element.
    property value : String | Nil
    # Value by default.
    property default : String | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
    # Html tag: select multiple
    property choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 6
  end

  # Type of selective field with dynamic addition of elements.
  # For simulate relationship Many-to-One.
  # Elements are added via the `ModelName::update_dyn_field()` method.
  struct ChoiceTextDynField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextDynField"
    # Sets the value of an element.
    property value : String | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 5
  end

  # Type of selective field with dynamic addition of elements.
  # For simulate relationship Many-to-Many.
  # Elements are added via the `ModelName::update_dyn_field()` method.
  struct ChoiceTextMultDynField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultDynField"
    # Sets the value of an element.
    property value : String | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    property is_unique : Bool = false
    # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 7
  end
end
