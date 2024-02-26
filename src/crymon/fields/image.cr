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
    # Default file path.
    # <br>
    # _Example: "assets/media/default/noavatar.jpg"_
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # Root directory for storing media files.
    property media_root : String
    # URL address for the media directory.
    getter media_url : String
    # Directory for files inside media directory (inner path).
    # <br>
    # _Example: "files/resume"_
    getter target_dir : String
    # HTML attribute: accept.
    # <br>
    # Describing which file types to allow.
    # <br>
    # _Example: "image/png,image/jpeg,image/webp"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = "image/png,image/jpeg,image/webp"
    # From one to four inclusive.
    # <br>
    # _Example: [{"xs", 150},{"sm", 300},{"md", 600},{"lg", 1200}]_
    getter thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new
    # The maximum allowed image size in megabytes.
    getter maxsize : Float32
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 5
    #
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter regex : Nil
    # :nodoc:
    getter regex_err_msg : Nil
    # :nodoc:
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter choices : Nil

    # :nodoc:
    def has_value?; end

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @media_root : String = "assets/media",
      @media_url : String = "/media",
      @target_dir : String = "images",
      @thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new,
      @maxsize : Float32 = 2.0,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t("allowed_files.interpolation", types: "jpg/jpeg, png and webp"),
      @warning : String = ""
    ); end
  end
end
