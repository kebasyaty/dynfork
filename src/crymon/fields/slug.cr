require "./field"

module Crymon
  module Fields
    # Automatically creates a label from letters, numbers, and hyphens.
    # Convenient to use for Url addresses.
    struct SlugField < Crymon::Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "SlugField"
      # Html tag: input type="url".
      getter input_type : String = "text"
      # Sets the value of an element.
      property value : String | Nil
      # Displays prompt text.
      property placeholder : String
      # The unique value of a field in a collection.
      property is_unique : Bool
      # Names of the fields whose contents will be used for the slug.
      # NOTE: The default is ["hash"].
      # NOTE: Examples: ["title"] | ["hash", "username"] | ["email", "first_name", "last_name"].
      property slug_sources : Array(String)
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 2

      def initialize(
        @label : String = "",
        @placeholder : String = "",
        @is_hide : Bool = false,
        @is_unique : Bool = true,
        @is_required : Bool = false,
        @is_disabled : Bool = false,
        @is_readonly : Bool = true,
        @slug_sources : Array(String) = ["hash"],
        @other_attrs : String = "",
        @css_classes : String = "",
        @hint : String = "",
        @warning : String = ""
      ); end
    end
  end
end
