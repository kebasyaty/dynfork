require "./field"

module Crymon::Fields
  # Automatically creates a label from letters, numbers, and hyphens.
  # Convenient to use for Url addresses.
  struct SlugField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "SlugField"
    # Html tag: input type="url".
    getter input_type : String = "text"
    # Sets the value of an element.
    property value : String?
    # Displays prompt text.
    getter placeholder : String
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Names of the fields whose contents will be used for the slug.
    # <br>
    # The default is ["hash"].
    # <br>
    # _Examples: ["title"] | ["hash", "username"] | ["email", "first_name", "last_name"]_
    getter slug_sources : Array(String)
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 2
    #
    # WARNING: Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @placeholder : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = true,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = true,
      @is_ignored : Bool = false,
      @slug_sources : Array(String) = ["hash"],
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end

    # To work around the error - undefined method 'slug_sources='.
    def get_slug_sources : Array(String)
      @slug_sources
    end
  end
end
