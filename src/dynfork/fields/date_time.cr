require "./field"

module DynFork::Fields
  # A field for entering a date and time.
  # <br>
  # _**Formats:** dd-mm-yyyy hh:mm:ss | dd/mm/yyyy hh:mm:ss | dd.mm.yyyy hh:mm:ss |
  # dd-mm-yyyyThh:mm:ss | dd/mm/yyyyThh:mm:ss | dd.mm.yyyyThh:mm:ss |
  # yyyy-mm-dd hh:mm:ss | yyyy/mm/dd hh:mm:ss | yyyy.mm.dd hh:mm:ss |
  # yyyy-mm-ddThh:mm:ss | yyyy/mm/ddThh:mm:ss | yyyy.mm.ddThh:mm:ss_
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct DateTimeField < DynFork::Fields::Field
    include DynFork::Globals::Date

    # Field type - Structure Name.
    getter field_type : String = "DateTimeField"
    # Html tag: input type="datetime".
    getter! input_type : String?
    # Sets the value of an element.
    # <br>
    # _Example: 1970-01-01T00:00:00_
    property! value : String?
    # Value by default.
    # <br>
    # _Example: 1970-01-01T00:00:00_
    getter! default : String?
    # Displays prompt text.
    getter placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # The top value for entering a date and time.
    getter! max : String?
    # The lower value for entering a date and time.
    getter! min : String?
    # Additional explanation for the user.
    getter hint : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 2
    #
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
    getter? unique : Bool = false

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
    def refrash_val_str(val : String); end

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
      @max : String? = nil,
      @min : String? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t(
        "formats.interpolation", samples: "dd-mm-yyyy hh:mm:ss | dd/mm/yyyy hh:mm:ss | " +
                                          "dd.mm.yyyy hh:mm:ss | dd-mm-yyyyThh:mm:ss | " +
                                          "dd/mm/yyyyThh:mm:ss | dd.mm.yyyyThh:mm:ss | " +
                                          "yyyy-mm-dd hh:mm:ss | yyyy/mm/dd hh:mm:ss | " +
                                          "yyyy.mm.dd hh:mm:ss | yyyy-mm-ddThh:mm:ss | " +
                                          "yyyy/mm/ddThh:mm:ss | yyyy.mm.ddThh:mm:ss")
    )
      @input_type = "datetime"
    end

    # Get time object from value.
    def time_object? : Time?
      self.datetime_parse(@value.as(String)) unless @value.nil?
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_datetime(val : Time) : Nil
      @value = val.to_s("%FT%H:%M:%S")
    end
  end
end
