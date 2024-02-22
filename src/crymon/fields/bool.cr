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
    # :nodoc:
    getter max : Nil
    # WARNING: Stub
    # :nodoc:
    getter min : Nil
    # WARNING: Stub
    # :nodoc:
    getter regex : Nil
    # WARNING: Stub
    # :nodoc:
    getter regex_err_msg : Nil
    # WARNING: Stub
    # :nodoc:
    getter maxlength : Nil
    # WARNING: Stub
    # :nodoc:
    getter minlength : Nil
    # WARNING: Stub
    # :nodoc:
    getter? unique : Bool = false
    # WARNING: Stub
    # :nodoc:
    getter choices : Nil
    # WARNING: Stub
    # :nodoc:
    getter? required : Bool = false
    # WARNING: Stub
    # :nodoc:
    getter? readonly : Bool = false
    # WARNING: Stub
    # :nodoc:
    getter maxsize : Nil

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
