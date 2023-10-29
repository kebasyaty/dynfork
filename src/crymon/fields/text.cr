require "./field"

module Crymon
  module Fields
    # A field for entering a text string.
    struct TextField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "TextField"
      # Html tag: input type="text".
      getter input_type : String = "text"
      # For Html textarea.
      property is_textarea : Bool
      # Sets the value of an element.
      property value : String | Nil
      # Value by default.
      getter default : String | Nil
      # Displays prompt text.
      property placeholder : String
      # The maximum number of characters allowed in the text.
      property maxlength : UInt32
      # The minimum number of characters allowed in the text.
      property minlength : UInt32
      # The unique value of a field in a collection.
      property is_unique : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 1

      def initialize(
        @label : String = "",
        @default : String | Nil = nil,
        @placeholder : String = "",
        @maxlength : UInt32 = 256,
        @minlength : UInt32 = 0,
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_textarea : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = ""
      ); end
    end
  end
end
