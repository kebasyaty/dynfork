require "./field"

module Crymon::Fields
  # Boolean field.
  struct BoolField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "BoolField"
    # Field type - Html, input type.
    getter input_type : String = "checkbox"
    # Sets the value of an element.
    property value : Bool?
    # Value by default.
    getter default : Bool?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 12
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
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter? unique : Bool = false
    # WARNING: Stub
    getter choices : Nil
    # WARNING: Stub
    getter? required : Bool = false
    # WARNING: Stub
    getter? readonly : Bool = false

    def initialize(
      @label : String = "",
      @default : Bool? = false,
      @hide : Bool = false,
      @disabled : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    ); end
  end
end
