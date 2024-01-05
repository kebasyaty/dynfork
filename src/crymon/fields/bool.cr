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
    # WARNING: Stubs
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @default : Bool? = false,
      @is_hide : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = ""
    ); end
  end
end
