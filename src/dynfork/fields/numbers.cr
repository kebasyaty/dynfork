require "./field"

module DynFork::Fields
  # Field for entering integer 64-bit numbers.
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
    # The maximum number of characters allowed in the text.
    getter! max : Int64?
    # The minimum number of characters allowed in the text.
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
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter! choices : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

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
    def extract_file_data? : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data? : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def extract_val_f64? : Float64?; end

    # :nodoc:
    def extract_default_f64? : Float64?; end

    # :nodoc:
    def extract_images_dir_path? : String?; end

    # :nodoc:
    def extract_file_path? : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
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
      @warning : String = ""
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
    def extract_val_i64? : Int64?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_default_i64? : Int64?
      @default
    end
  end

  # Field for entering float 64-bit numbers.
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
    # The maximum number of characters allowed in the text.
    getter! max : Float64?
    # The minimum number of characters allowed in the text.
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
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter! choices : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

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
    def extract_file_data? : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data? : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def extract_val_i64? : Int64?; end

    # :nodoc:
    def extract_default_i64? : Int64?; end

    # :nodoc:
    def images_dir_path? : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
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
      @warning : String = ""
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
    def extract_val_f64? : Float64?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_default_f64? : Float64?
      @default
    end
  end
end
