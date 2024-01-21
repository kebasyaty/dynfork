require "./field"

module Crymon::Fields
  # Field for entering color.
  # <br>
  # The default value is _#000000_ (black).
  # <br>
  # Html input type="text".
  # WARNING: type="color" only seven-character hexadecimal notation.
  # <br>
  # _Examples: #fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) |
  # rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff_
  struct ColorField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ColorField"
    # Html tag: input type="color".
    # <br>
    # By default type="text".
    # WARNING: type="color" only seven-character hexadecimal notation.
    getter input_type : String = "text"
    # Sets the value of an element.
    property value : String?
    # The default value is #000000.
    getter default : String?
    # Displays prompt text.
    property placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : Int32?
    # The minimum number of characters allowed in the text.
    getter minlength : Int32?
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # WARNING: Stub
    getter max : Nil
    # WARNING: Stub
    getter min : Nil
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter choices : Nil

    def initialize(
      @label : String = "",
      @default : String? = "#000000",
      @placeholder : String = "",
      @maxlength : Int32? = 256,
      @minlength : Int32? = 0,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = I18n.t(
        "examples.interpolation", samples: "#fff | #f2f2f2 | #f2f2f200 | " +
                                           "rgb(255,0,24) | rgba(255,0,24,0.5) | " +
                                           "rgba(#fff,0.5) | hsl(120,100%,50%) | " +
                                           "hsla(170,23%,25%,0.2) | 0x00ffff")
    ); end
  end
end
