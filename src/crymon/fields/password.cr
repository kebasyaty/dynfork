require "./field"

module Crymon
  module Fields
    # Field for entering password.
    struct PasswordField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "PasswordField"
      # Html tag: input type="url".
      getter input_type : String = "password"
      # Sets the value of an element.
      property value : String | Nil
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
        @placeholder : String = "",
        @maxlength : UInt32 = 256,
        @minlength : UInt32 = 8,
        @regex : String = "^[a-zA-Z0-9@#$%^&+=*!~)(]{8,256}$",
        @regex_err_msg : String = "Allowed chars: a-z A-Z 0-9 @ # $ % ^ & + = * ! ~ ) (",
        @is_hide : Bool = false,
        @is_unique : Bool = false,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "",
        @warning : String = ""
      ); end
    end
  end
end
