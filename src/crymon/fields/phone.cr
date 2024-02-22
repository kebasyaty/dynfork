require "./field"

module Crymon::Fields
  # Field for entering Phone number.
  struct PhoneField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "PhoneField"
    # Html tag: input type="url".
    getter input_type : String = "tel"
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : Int32
    # The minimum number of characters allowed in the text.
    getter minlength : Int32
    # Regular expression to validate the `value`.
    getter regex : String?
    # Error message.
    getter regex_err_msg : String?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # WARNING: Stub
    # :nodoc:
    getter max : Nil
    # WARNING: Stub
    # :nodoc:
    getter min : Nil
    # WARNING: Stub
    # :nodoc:
    getter choices : Nil
    # WARNING: Stub
    # :nodoc:
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : Int32 = 15,
      @minlength : Int32 = 8,
      @regex : String? = "^+?[0-9]{8,15}$",
      @regex_err_msg : String? = I18n.t(:invalid_phone),
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t("format.interpolation", sample: "+xxxxxxxx... or xxxxxxxx..."),
      @warning : String = ""
    ); end
  end
end
