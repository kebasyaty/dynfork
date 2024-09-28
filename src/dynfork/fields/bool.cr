require "./field"

module DynFork::Fields
  # Boolean field.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct BoolField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "BoolField"
    # Html tag: input type="checkbox".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : Bool?
    # Value by default.
    getter! default : Bool?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 8
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! max : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! min : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! regex : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! regex_err_msg : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! maxlength : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! minlength : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter? unique : Bool = false
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter! choices : Nil
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter? required : Bool = false
    # :nodoc:
    @[JSON::Field(ignore: true)]
    getter? readonly : Bool = false
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
      @default : Bool? = false,
      @hide : Bool = false,
      @disabled : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    )
      @input_type = "checkbox"
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_bool(val : Bool)
      @value = val
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_val_bool? : Bool?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_default_bool? : Bool?
      @default
    end
  end
end
