require "./field"

module Crymon
  module Fields
    # Type of selective field with static of elements.
    # NOTE: With a single choice.
    struct ChoiceTextField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ChoiceTextField"
      # Sets the value of an element.
      property value : String | Nil = nil
      # Value by default.
      getter default : String | Nil
      # Specifies that multiple options can be selected at once.
      getter is_multiple : Bool = false
      # The unique value of a field in a collection.
      getter is_unique : Bool = false
      # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
      # NOTE: Html tag: select
      property choices : Array(Tuple(String, String))
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 4

      def initialize(
        @label : String = "",
        @default : String | Nil = nil,
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "",
        @choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
      ); end
    end

    # Type of selective field with static of elements.
    # NOTE: With multiple choice.
    struct ChoiceTextMultField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ChoiceTextMultField"
      # Sets the value of an element.
      property value : Array(String) | Nil = nil
      # Value by default.
      getter default : Array(String) | Nil
      # Specifies that multiple options can be selected at once.
      getter is_multiple : Bool = true
      # The unique value of a field in a collection.
      getter is_unique : Bool = false
      # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
      # NOTE: Html tag: select multiple
      property choices : Array(Tuple(String, String))
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 6

      def initialize(
        @label : String = "",
        @default : Array(String) | Nil = nil,
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "",
        @choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
      ); end
    end

    # Type of selective field with dynamic addition of elements.
    # NOTE: For simulate relationship Many-to-One.
    # NOTE: Elements are added via the `ModelName::update_dyn_field()` method.
    struct ChoiceTextDynField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ChoiceTextDynField"
      # Sets the value of an element.
      property value : String | Nil = nil
      # Value by default.
      getter default : Nil = nil
      # Specifies that multiple options can be selected at once.
      getter is_multiple : Bool = false
      # The unique value of a field in a collection.
      getter is_unique : Bool = false
      # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
      # NOTE: Html tag: select
      property choices : Array(Tuple(String, String))
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 5

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
        @choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
      ); end
    end

    # Type of selective field with dynamic addition of elements.
    # NOTE: For simulate relationship Many-to-Many.
    # NOTE: Elements are added via the `ModelName::update_dyn_field()` method.
    struct ChoiceTextMultDynField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ChoiceTextMultDynField"
      # Sets the value of an element.
      property value : Array(String) | Nil = nil
      # Value by default.
      getter default : Nil = nil
      # Specifies that multiple options can be selected at once.
      getter is_multiple : Bool = true
      # The unique value of a field in a collection.
      getter is_unique : Bool
      # Example: [{"value", "Title"}, {"value 2", "Title 2"}].
      # NOTE: Html tag: select
      property choices : Array(Tuple(String, String))
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 7

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
        @choices : Array(Tuple(String, String)) = Array(Tuple(String, String)).new
      ); end
    end
  end
end
