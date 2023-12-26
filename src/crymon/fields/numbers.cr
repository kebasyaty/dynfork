require "./field"

module Crymon::Fields
  # Field for entering unsigned 32-bit integers.
  struct U32Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "U32Field"
    # Html tag: input type="number|range".
    getter input_type : String = "number"
    # Sets the value of an element.
    property value : UInt32?
    # Value by default.
    getter default : UInt32?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter max : UInt32
    # The minimum number of characters allowed in the text.
    getter min : UInt32
    # Increment step for numeric fields.
    getter step : UInt32
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 10

    def initialize(
      @label : String = "",
      @default : UInt32? = nil,
      @input_type : String = "number", # number | range
      @placeholder : String = "",
      @max : UInt32 = UInt32::MAX,
      @min : UInt32 = 0,
      @step : UInt32 = 1,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    )
      if ["number", "range"].index(@input_type).nil?
        raise Crymon::Errors::InvalidInputType.new(@input_type)
      end
    end
  end

  # Field for entering integer 64-bit numbers.
  struct I64Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "I64Field"
    # Html tag: input type="number|range".
    getter input_type : String = "number"
    # Sets the value of an element.
    property value : Int64?
    # Value by default.
    getter default : Int64?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter max : Int64
    # The minimum number of characters allowed in the text.
    getter min : Int64
    # Increment step for numeric fields.
    getter step : Int64
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 10

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @input_type : String = "number", # number | range
      @placeholder : String = "",
      @max : Int64 = Int64::MAX,
      @min : Int64 = 0,
      @step : Int64 = 1,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    )
      if ["number", "range"].index(@input_type).nil?
        raise Crymon::Errors::InvalidInputType.new(@input_type)
      end
    end
  end

  # Field for entering float 64-bit numbers.
  struct F64Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "F64Field"
    # Html tag: input type="number|range".
    getter input_type : String
    # Sets the value of an element.
    property value : Float64?
    # Value by default.
    getter default : Float64?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter max : Float64
    # The minimum number of characters allowed in the text.
    getter min : Float64
    # Increment step for numeric fields.
    getter step : Float64
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 11

    def initialize(
      @label : String = "",
      @default : Float64? = nil,
      @input_type : String = "number", # number | range
      @placeholder : String = "",
      @max : Float64 = Float64::MAX,
      @min : Float64 = 0.0,
      @step : Float64 = 1.0,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    )
      if ["number", "range"].index(@input_type).nil?
        raise Crymon::Errors::InvalidInputType.new(@input_type)
      end
    end
  end
end
