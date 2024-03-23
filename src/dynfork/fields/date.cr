require "./field"

module DynFork::Fields
  # A field for entering a date.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  struct DateField < DynFork::Fields::Field
    include DynFork::Tools::Date

    # Field type - Structure Name.
    getter field_type : String = "DateField"
    # Html tag: input type="date".
    getter! input_type : String?
    # Sets the value of an element.
    # <br>
    # _Example: 1970-01-01_
    property! value : String?
    # Value by default.
    # <br>
    # _Example: 1970-01-01_
    getter! default : String?
    # Displays prompt text.
    getter placeholder : String
    # The top value for entering a date.
    getter! max : String?
    # The lower value for entering a date.
    getter! min : String?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Additional explanation for the user.
    getter hint : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 2
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
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def extract_val_i64? : Int64?; end

    # :nodoc:
    def extract_default_i64? : Int64?; end

    # :nodoc:
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def path_to_file(
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
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t(
        "formats.interpolation", samples: "dd-mm-yyyy | dd/mm/yyyy | " +
                                          "dd.mm.yyyy | yyyy-mm-dd | " +
                                          "yyyy/mm/dd | yyyy.mm.dd")
    )
      @input_type = "date"
    end

    # Get time object from value.
    def time_object? : Time?
      self.date_parse(@value.as(String)) unless @value.nil?
    end

    def refrash_val_date(val : Time)
      @value = val.to_s("%F")
    end
  end
end
