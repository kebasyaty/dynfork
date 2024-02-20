require "./field"

module Crymon::Fields
  # File upload field.
  struct FileField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "FileField"
    # Html tag: input type="url".
    getter input_type : String = "file"
    # Sets the value of an element.
    property value : Crymon::Globals::FileData?
    # Value by default.
    getter default : Crymon::Globals::FileData?
    # Root directory for storing media files.
    getter media_root : String
    # URL address for the media directory.
    getter media_url : String
    # Directory for files inside media directory (inner path).
    # <br>
    # *Example: "files/resume"*
    getter target_dir : String
    # HTML attribute: accept
    # <br>
    # Describing which file types to allow.
    # <br>
    # _Example: "image/jpeg,image/png,image/gif"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = ""
    # Displays prompt text.
    getter placeholder : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 8
    #
    # WARNING: Stub
    getter max : Nil
    # WARNING: Stub
    getter min : Nil
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter? unique : Bool = false
    # WARNING: Stub
    getter choices : Nil

    def initialize(
      @label : String = "",
      @default : Crymon::Globals::FileData? = nil,
      @media_root : String = "assets/media",
      @media_url : String = "/media",
      @target_dir : String = "files",
      @accept : String = "",
      @placeholder : String = "",
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    ); end
  end
end
