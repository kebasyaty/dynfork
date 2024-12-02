require "./field"

module DynFork::Fields
  # Field for entering color.
  # NOTE: The default value is _#000000_ (black).
  # NOTE: Html input type="text".
  # WARNING: type="color" only seven-character hexadecimal notation.
  # WARNING: Used validator `Valid.color_code?`.
  # NOTE: **Examples:** _#fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) |
  # rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff_
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct ColorField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ColorField"
    # Html tag: input type="color".
    # NOTE: By default type="text".
    # WARNING: type="color" only seven-character hexadecimal notation.
    getter! input_type : String?
    # Sets the value of an element.
    property! value : String?
    # The default value is #000000.
    getter! default : String?
    # Displays prompt text.
    property placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

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
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

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
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

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
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
    ); end

    def initialize(
      @label : String = "",
      @default : String? = "#000000",
      @placeholder : String = "",
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = [I18n.t(
        "examples.interpolation", samples: "#fff | #f2f2f2 | #f2f2f200 | " +
                                           "rgb(255,0,24) | rgba(255,0,24,0.5) | " +
                                           "rgba(#fff,0.5) | hsl(120,100%,50%) | " +
                                           "hsla(170,23%,25%,0.2) | 0x00ffff")],
    )
      @input_type = "text"
      @minlength = 0
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_str(val : String) : Nil
      @value = val
    end
  end
end
