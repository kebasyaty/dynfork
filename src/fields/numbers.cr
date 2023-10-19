require "./field"

module Fields
  # Field for entering unsigned 32-bit integers.
  struct U32Field < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "U32Field"
    # Html tag: input type="url".
    getter input_type : String = "number"
    # Sets the value of an element.
    property value : UInt32 | Nil
    # Value by default.
    property default : UInt32 | Nil
    # Displays prompt text.
    property placeholder : String
    # The maximum number of characters allowed in the text.
    property max : UInt32
    # The minimum number of characters allowed in the text.
    property min : UInt32
    # Increment step for numeric fields.
    property step : UInt32
    # The unique value of a field in a collection.
    property is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 11

    def initialize(
      @label : String = "",
      @default : UInt32 | Nil = nil,
      @placeholder : String = "",
      @max : UInt32 = UInt32::MAX,
      @min : UInt32 = 0,
      @step : UInt32 = 1,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end

  # Field for entering integer 64-bit numbers.
  struct I64Field < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "I64Field"
    # Html tag: input type="url".
    getter input_type : String = "number"
    # Sets the value of an element.
    property value : Int64 | Nil
    # Value by default.
    property default : Int64 | Nil
    # Displays prompt text.
    property placeholder : String
    # The maximum number of characters allowed in the text.
    property max : Int64
    # The minimum number of characters allowed in the text.
    property min : Int64
    # Increment step for numeric fields.
    property step : Int64
    # The unique value of a field in a collection.
    property is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 11

    def initialize(
      @label : String = "",
      @default : Int64 | Nil = nil,
      @placeholder : String = "",
      @max : Int64 = Int64::MAX,
      @min : Int64 = 0,
      @step : Int64 = 1,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end
