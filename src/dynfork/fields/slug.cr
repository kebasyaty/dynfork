require "./field"

module DynFork::Fields
  # Automatically creates a label from letters, numbers, and hyphens.
  # <br>
  # Convenient to use for Url addresses.
  # <br>
  # WARNING: Allowed field types: _HashField_, _TextField_, _EmailField_,
  # _DateField_, _DateTimeField_, _I64Field_, _F64Field_.
  struct SlugField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "SlugField"
    # Html tag: input type="url".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : String?
    # Displays prompt text.
    getter placeholder : String
    # The unique value of a field in a collection.
    getter? unique : Bool = true
    # Names of the fields whose contents will be used for the slug.
    # <br>
    # The default is ["hash"].
    # <br>
    # _Examples: ["title"] | ["hash", "username"] | ["email", "first_name", "last_name"]_
    @slug_sources : Array(String)
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 9
    #
    # :nodoc:
    getter! default : Nil
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
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
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    def initialize(
      @label : String = "",
      @placeholder : String = "",
      @hide : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = true,
      @ignored : Bool = false,
      @slug_sources : Array(String) = ["hash"],
      @hint : String = "",
      @warning : String = ""
    )
      @input_type = "text"
    end

    # Getter for 'slug_sources'.
    def slug_sources : Array(String)
      @slug_sources
    end

    def refrash_val_str(val : String)
      @value = val
    end
  end
end
