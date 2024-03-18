require "./field"

module DynFork::Fields
  # Boolean field.
  struct BoolField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "BoolField"
    # Field type - Html, input type.
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
    getter? unique : Bool = false
    # :nodoc:
    getter! choices : Nil
    # :nodoc:
    getter? required : Bool = false
    # :nodoc:
    getter? readonly : Bool = false
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

    def refrash_val_bool(val : Bool)
      @value = val
    end
  end
end
