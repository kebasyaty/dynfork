require "./field"

module Fields
  # Type of selective field with static of elements.
  # With a single choice.
  struct ChoiceU32Field < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32Field"
    # Sets the value of an element.
    property value : UInt32 | Nil
    # Value by default.
    property default : UInt32 | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    property is_unique : Bool
    # Example: [{5, "Title"}, {10, "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt8 = 4

    def initialize(
      @label : String = "",
      @default : UInt32 | Nil = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end

  # Type of selective field with static of elements.
  # With multiple choice.
  struct ChoiceU32MultField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32MultField"
    # Sets the value of an element.
    property value : Array(UInt32) | Nil
    # Value by default.
    property default : Array(UInt32) | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    property is_unique : Bool
    # Example: [{5, "Title"}, {10, "Title 2"}].
    # Html tag: select multiple
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 6

    def initialize(
      @label : String = "",
      @default : Array(UInt32) | Nil = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end

  # Type of selective field with dynamic addition of elements.
  # For simulate relationship Many-to-One.
  # Elements are added via the `ModelName::update_dyn_field()` method.
  struct ChoiceU32DynField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32DynField"
    # Sets the value of an element.
    property value : UInt32 | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = false
    # The unique value of a field in a collection.
    property is_unique : Bool
    # Example: [{5, "Title"}, {10, "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 5

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end

  # Type of selective field with dynamic addition of elements.
  # For simulate relationship Many-to-Many.
  # Elements are added via the `ModelName::update_dyn_field()` method.
  struct ChoiceU32MultDynField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceU32MultDynField"
    # Sets the value of an element.
    property value : Array(UInt32) | Nil
    # Specifies that multiple options can be selected at once.
    getter is_multiple : Bool = true
    # The unique value of a field in a collection.
    property is_unique : Bool
    # Example: [{5, "Title"}, {10, "Title 2"}].
    # Html tag: select
    property choices : Array(Tuple(UInt32, String))
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 7

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(UInt32, String)) = Array(Tuple(UInt32, String)).new
    ); end
  end
end
