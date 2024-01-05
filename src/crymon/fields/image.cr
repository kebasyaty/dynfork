require "./field"

module Crymon::Fields
  # File upload field.
  struct ImageField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ImageField"
    # Html tag: input type="url".
    getter input_type : String = "file"
    # Sets the value of an element.
    property value : Crymon::Globals::ImageData?
    # Value by default.
    getter default : Crymon::Globals::ImageData?
    # Displays prompt text.
    getter placeholder : String
    # Root directory for storing media files.
    property media_root : String = "../../assets/media"
    # URL address for the media directory.
    getter media_url : String = "/media"
    # Directory for files inside media directory (inner path).
    # <br>
    # _Example: "files/resume"_
    getter target_dir : String = "images"
    # HTML attribute: accept.
    # <br>
    # Describing which file types to allow.
    # <br>
    # _Example: "image/jpeg,image/png,image/gif"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = ""
    # From one to four inclusive.
    # <br>
    # _Example: [{"xs", 150},{"sm", 300},{"md", 600},{"lg", 1200}]_
    # NOTE: An Intel i7-4770 processor or better is recommended.
    getter thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new
    # Thumbnail quality level: - Fast=false or Qualitatively=true.
    # <br>
    # By default: true.
    getter? is_quality : Bool = true
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 9
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
      @default : Crymon::Globals::ImageData? = nil,
      @placeholder : String = "",
      @media_root : String = "../../assets/media",
      @media_url : String = "/media",
      @target_dir : String = "images",
      @accept : String = "",
      @thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new,
      @is_quality : Bool = true,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end
