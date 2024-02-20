require "./field"

module Crymon::Fields
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
    getter max : Int64?
    # The minimum number of characters allowed in the text.
    getter min : Int64?
    # Increment step for numeric fields.
    getter step : Int64?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 10
    #
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter choices : Nil

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @input_type : String = "number", # number | range
      @placeholder : String = "",
      @max : Int64? = Int64::MAX,
      @min : Int64? = Int64::MIN,
      @step : Int64? = 1,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    )
      if ["number", "range"].index(@input_type).nil?
        raise Crymon::Errors::Fields::InvalidInputType.new(@input_type)
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
    getter max : Float64?
    # The minimum number of characters allowed in the text.
    getter min : Float64?
    # Increment step for numeric fields.
    getter step : Float64?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 11
    #
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter choices : Nil

    def initialize(
      @label : String = "",
      @default : Float64? = nil,
      @input_type : String = "number", # number | range
      @placeholder : String = "",
      @max : Float64? = Float64::MAX,
      @min : Float64? = Float64::MIN,
      @step : Float64? = 1.0,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    )
      if ["number", "range"].index(@input_type).nil?
        raise Crymon::Errors::Fields::InvalidInputType.new(@input_type)
      end
    end
  end
end
