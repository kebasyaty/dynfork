require "./field"

module Crymon::Fields
  # Field for entering Email addresses.
  struct EmailField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "EmailField"
    # Html tag: input type="url".
    getter input_type : String = "email"
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : UInt32
    # The minimum number of characters allowed in the text.
    getter minlength : UInt32
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @maxlength : UInt32 = 320,
      @minlength : UInt32 = 0,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
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
