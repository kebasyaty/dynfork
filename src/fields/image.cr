require "./field"
require "json"

module Fields
  # File upload field.
  struct ImageField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ImageField"
    # Html tag: input type="url".
    getter input_type : String = "file"
    # Sets the value of an element.
    property value : ImageData | Nil
    # Value by default.
    property default : ImageData | Nil
    # Displays prompt text.
    property placeholder : String
    # Root directory for storing media files.
    property media_root : String = "../../assets/media"
    # URL address for the media directory.
    property media_url : String = "/media"
    # Directory for files inside media directory (inner path).
    # Example: "files/resume".
    property target_dir : String = "images"
    # HTML attribute: accept.
    # Describing which file types to allow.
    # Example: "image/jpeg,image/png,image/gif"
    # https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    property accept : String = ""
    # From one to four inclusive.
    # Example: [{"xs", 150},{"sm", 300},{"md", 600},{"lg", 1200}].
    # Hint: An Intel i7-4770 processor or better is recommended.
    property thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new
    # Thumbnail quality level: - Fast=false or Qualitatively=true.
    # By default: true.
    property is_quality : Bool = true
    # The unique value of a field in a collection.
    property is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 9

    def initialize(
      @label : String = "",
      @default : ImageData | Nil = nil,
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
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @warning : String = ""
    ); end
  end

  # Helper structure for ImageField.
  struct ImageData
    include JSON::Serializable
    include JSON::Serializable::Strict
    # # Path to  file.
    property path : String
    property path_xs : String = ""
    property path_sm : String = ""
    property path_md : String = ""
    property path_lg : String = ""
    # URL to the file.
    property url : String = ""
    property url_xs : String = ""
    property url_sm : String = ""
    property url_md : String = ""
    property url_lg : String = ""
    # File name.
    property name : String = ""
    # File size in bytes.
    property size : Float64 = 0
    # File width in pixels.
    property width : Float64 = 0
    # File height in pixels.
    property height : Float64 = 0
    # If the file needs to be deleted: is_delete=true.
    # By default is_delete=false.
    property is_delete : Bool

    def initialize(
      @path : String = "",
      @is_delete : Bool = false
    ); end
  end
end
