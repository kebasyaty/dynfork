require "./field"

module Crymon::Fields
  # A field for entering a date in the format yyyy-mm-dd.
  # <br>
  # _Example: 1970-01-01_
  struct DateField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "DateField"
    # Html tag: input type="date".
    getter input_type : String = "date"
    # Sets the value of an element.
    # <br>
    # _Example: 1970-01-01_
    property value : String?
    # Value by default.
    # <br>
    # _Example: 1970-01-01_
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The top value for entering a date.
    getter max : String?
    # The lower value for entering a date.
    getter min : String?
    # The unique value of a field in a collection.
    getter is_unique : Bool
    # Additional explanation for the user.
    getter hint : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @max : String? = nil,
      @min : String? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "Format: yyyy-mm-dd"
    ); end
  end
end
