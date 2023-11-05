require "./field"

module Crymon
  module Fields
    # This type was created specifically for the hash field.
    struct HashField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "HashField"
      # Html tag: input type="url".
      getter input_type : String = "text"
      # Sets the value of an element.
      property value : String?
      # Value by default.
      getter default : Nil
      # Displays prompt text.
      getter placeholder : String
      # The maximum number of characters allowed in the text.
      getter maxlength : UInt32
      # The minimum number of characters allowed in the text.
      getter minlength : UInt32
      # The unique value of a field in a collection.
      getter is_unique : Bool
      # Hide field from user.
      property is_hide : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 1

      def initialize(
        @label : String = "Hash ID",
        @placeholder : String = "Enter the Document ID for MongoDB",
        @maxlength : UInt32 = 24,
        @minlength : UInt32 = 24,
        @is_hide : Bool = true,
        @is_unique : Bool = true,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = false,
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "For enter a document ID"
      ); end
    end
  end
end
