require "./field"

module DynFork::Fields
  # Field for entering password.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/password" target="_blank">example</a>.
  # WARNING: Default regular expression: /^[-._!"`'#%&,:;<>=@{}~\$\(\)\*\+\/\\\?\[\]\^\|a-zA-Z0-9]+$/
  # WARNING: Valid characters by default: a-z A-Z 0-9 - . _ ! " ` ' # % & , : ; < > = @ { } ~ $ ( ) * + / \ ? [ ] ^ |
  # WARNING: Default number of characters: max = 256, min = 8
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct PasswordField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "PasswordField"
    # Html tag: input type="password".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter! maxlength : UInt32?
    # The minimum number of characters allowed in the text.
    getter! minlength : UInt32?
    # Regular expression to validate the value.
    getter! regex : String?
    # Error message.
    getter! regex_err_msg : String?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! default : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! choices : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter? multiple : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
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
      @placeholder : String = "",
      @maxlength : UInt32? = 256,
      @minlength : UInt32? = 8,
      @regex : String? = nil,
      @regex_err_msg : String? = nil,
      @hide : Bool = false,
      @required : Bool = true,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    )
      @input_type = "password"
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_str(val : String) : Nil
      @value = val
    end
  end
end
