require "./field"

module DynFork::Fields
  # Field for entering integer 64-bit numbers.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct I64Field < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "I64Field"
    # Html tag: input type="number|range".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : Int64?
    # Value by default.
    getter! default : Int64?
    # Displays prompt text.
    getter placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # Maximum allowed number.
    getter! max : Int64?
    # Minimum allowed number.
    getter! min : Int64?
    # Increment step for numeric fields.
    getter! step : Int64?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 6
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! choices : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? multiple : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    def has_value?; end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_i64(val : Array(Int64)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false,
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false,
    ); end

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @input_type : String? = "number", # number | range
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
      @warning : Array(String) = Array(String).new,
    )
      unless ["number", "range"].includes?(self.input_type)
        raise DynFork::Errors::Fields::InvalidInputType.new(self.input_type)
      end
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_i64(val : Int64) : Nil
      @value = val
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_val_i64 : Int64?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_default_i64 : Int64?
      @default
    end
  end

  # Field for entering float 64-bit numbers.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct F64Field < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "F64Field"
    # Html tag: input type="number|range".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : Float64?
    # Value by default.
    getter! default : Float64?
    # Displays prompt text.
    getter placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # Maximum allowed number.
    getter! max : Float64?
    # Minimum allowed number.
    getter! min : Float64?
    # Increment step for numeric fields.
    getter! step : Float64?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 7
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! choices : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? multiple : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    def has_value?; end

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_i64(val : Array(Int64)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false,
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false,
    ); end

    def initialize(
      @label : String = "",
      @default : Float64? = nil,
      @input_type : String? = "number", # number | range
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
      @warning : Array(String) = Array(String).new,
    )
      unless ["number", "range"].includes?(self.input_type)
        raise DynFork::Errors::Fields::InvalidInputType.new(self.input_type)
      end
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_f64(val : Float64) : Nil
      @value = val
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_val_f64 : Float64?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_default_f64 : Float64?
      @default
    end

    # Add some number to the `value`.
    # NOTE: For secure calculations, `BigDecimal` is used.
    # NOTE: Rounded to two decimal places.
    # NOTE: Banikir rounding is used.
    # NOTE: For currencies, use the <a href="https://github.com/crystal-money/money" target="_blank">Money</a> shard.
    #
    # Example:
    # ```
    # model_name = ModelName.new
    # model_name.amount.finance_plus(12.5)
    # puts model_name.amount.value # => 12.5
    # ```
    #
    def finance_plus(num : Float | Int | BigInt | BigRational | BigDecimal | String) : Nil
      (@value = 0) if @value.nil?
      @value = ((BigDecimal.new(@value.not_nil!) + BigDecimal.new(num)).round(2)).to_f64
    end

    # Subtract some number to the “value”.
    # NOTE: For secure calculations, `BigDecimal` is used.
    # NOTE: Rounded to two decimal places.
    # NOTE: Banikir rounding is used.
    # NOTE: For currencies, use the <a href="https://github.com/crystal-money/money" target="_blank">Money</a> shard.
    #
    # Example:
    # ```
    # model_name = ModelName.new
    # model_name.amount.value = 12.5
    # model_name.amount.finance_minus(6.25)
    # puts model_name.amount.value # => 6.25
    # ```
    #
    def finance_minus(num : Float | Int | BigInt | BigRational | BigDecimal | String) : Nil
      (@value = 0) if @value.nil?
      @value = ((BigDecimal.new(@value.not_nil!) - BigDecimal.new(num)).round(2)).to_f64
    end

    # Divide `value` by some number.
    # NOTE: For secure calculations, `BigDecimal` is used.
    # NOTE: Rounded to two decimal places.
    # NOTE: Banikir rounding is used.
    # NOTE: For currencies, use the <a href="https://github.com/crystal-money/money" target="_blank">Money</a> shard.
    #
    # Example:
    # ```
    # model_name = ModelName.new
    # model_name.amount.value = 12.5
    # model_name.amount.finance_divide(2)
    # puts model_name.amount.value # => 6.25
    # ```
    #
    def finance_divide(num : Float | Int | BigInt | BigRational | BigDecimal | String) : Nil
      (@value = 0) if @value.nil?
      @value = ((BigDecimal.new(@value.not_nil!) / BigDecimal.new(num)).round(2)).to_f64
    end

    # Multiply `value` by some number.
    # NOTE: For secure calculations, `BigDecimal` is used.
    # NOTE: Rounded to two decimal places.
    # NOTE: Banikir rounding is used.
    # NOTE: For currencies, use the <a href="https://github.com/crystal-money/money" target="_blank">Money</a> shard.
    #
    # Example:
    # ```
    # model_name = ModelName.new
    # model_name.amount.value = 12.5
    # model_name.amount.finance_multiply(2)
    # puts model_name.amount.value # => 25.0
    # ```
    #
    def finance_multiply(num : Float | Int | BigInt | BigRational | BigDecimal | String) : Nil
      (@value = 0) if @value.nil?
      @value = ((BigDecimal.new(@value.not_nil!) * BigDecimal.new(num)).round(2)).to_f64
    end
  end
end
