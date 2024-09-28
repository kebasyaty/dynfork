require "./field"

module DynFork::Fields
  # A field for entering a text string.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct TextField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "TextField"
    # Html tag: input type="text".
    getter! input_type : String?
    # For Html textarea.
    getter? textarea : Bool
    # Whether or not to use your preferred text editor - CKEditor, TinyMCE, etc.
    getter? use_editor : Bool
    # Sets the value of an element.
    property! value : String?
    # Value by default.
    getter! default : String?
    # Displays prompt text.
    getter placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # The maximum number of characters allowed in the text.
    getter! maxlength : UInt32?
    # The minimum number of characters allowed in the text.
    getter! minlength : UInt32?
    # Regular expression to validate the `value`.
    getter! regex : String?
    # Error message.
    getter! regex_err_msg : String?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! min : Nil

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
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : UInt32? = 256,
      @minlength : UInt32? = 0,
      @regex : String? = nil,
      @regex_err_msg : String? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @textarea : Bool = false,
      @use_editor : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    )
      @input_type = "text"
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_str(val : String) : Nil
      @value = val
    end
  end
end
