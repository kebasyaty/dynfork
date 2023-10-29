require "./field"

module Crymon
  module Fields
    # A field for entering a date и времени in the format yyyy-mm-ddThh:mm.
    # NOTE: Example: 1970-01-01T00:00
    struct DateTimeField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "DateTimeField"
      # Html tag: input type="date".
      getter input_type : String = "datetime"
      # Sets the value of an element.
      # NOTE: Example: 1970-01-01T00:00
      property value : String | Nil
      # Value by default.
      # NOTE: Example: 1970-01-01T00:00
      getter default : String | Nil
      # Displays prompt text.
      getter placeholder : String
      # The top value for entering a date and time.
      getter max : String
      # The lower value for entering a date and time.
      getter min : String
      # The unique value of a field in a collection.
      getter is_unique : Bool
      # Additional explanation for the user.
      getter hint : String
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 3

      def initialize(
        @label : String = "",
        @default : String | Nil = nil,
        @placeholder : String = "",
        @max : String = "",
        @min : String = "",
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "Format: yyyy-mm-ddThh:mm"
      ); end
    end
  end
end
