require "./field"

module Crymon
  module Fields
    # Field for entering Phone number.
    struct PhoneField < Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "PhoneField"
      # Html tag: input type="url".
      getter input_type : String = "tel"
      # Sets the value of an element.
      property value : String | Nil
      # Value by default.
      property default : String | Nil
      # Displays prompt text.
      property placeholder : String
      # The maximum number of characters allowed in the text.
      property maxlength : UInt32
      # The minimum number of characters allowed in the text.
      property minlength : UInt32
      # Regular expression to validate the value.
      property regex : String
      # Error message.
      property regex_err_msg : String
      # The unique value of a field in a collection.
      property is_unique : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 1

      def initialize(
        @label : String = "",
        @default : String | Nil = nil,
        @placeholder : String = "",
        @maxlength : UInt32 = 15,
        @minlength : UInt32 = 8,
        @regex : String = "^+?[0-9]{8,15}$",
        @regex_err_msg : String = "Invalid Phone number.",
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "Format: +xxxxxxxx... or xxxxxxxx...",
        @warning : String = ""
      ); end
    end
  end
end
