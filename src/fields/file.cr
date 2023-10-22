require "./field"
require "json"

module Fields
  # File upload field.
  struct FileField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "FileField"
    # Html tag: input type="url".
    getter input_type : String = "file"
    # Sets the value of an element.
    property value : FileData | Nil
    # Value by default.
    property default : FileData | Nil
    # Root directory for storing media files.
    property media_root : String
    # URL address for the media directory.
    property media_url : String
    # Directory for files inside media directory (inner path).
    # Example: "files/resume".
    property target_dir : String
    # HTML attribute: accept
    # Describing which file types to allow.
    # Example: "image/jpeg,image/png,image/gif"
    # https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    property accept : String = ""
    # Displays prompt text.
    property placeholder : String
    # The unique value of a field in a collection.
    property is_unique : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 8

    def initialize(
      @label : String = "",
      @default : FileData | Nil = nil,
      @media_root : String = "../assets/media",
      @media_url : String = "/media",
      @target_dir : String = "files",
      @accept : String = "",
      @placeholder : String = "",
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

  # Helper structure for FileField.
  struct FileData
    include JSON::Serializable
    include JSON::Serializable::Strict
    # Path to  file.
    property path : String
    # URL to the file.
    property url : String = ""
    # File name.
    property name : String = ""
    # File size in bytes.
    property size : Float64 = 0
    # If the file needs to be deleted: is_delete=true.
    # By default is_delete=false.
    property is_delete : Bool

    def initialize(
      @path : String = "",
      @is_delete : Bool = false
    ); end
  end
end
