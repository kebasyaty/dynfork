require "./field"

module Crymon::Fields
  # Field for entering URL addresses.
  struct URLField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "URLField"
    # Html tag: input type="url".
    getter input_type : String = "url"
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
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
    # WARNING: Stubs
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : Int32? = 2048,
      @minlength : Int32? = 0,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end
