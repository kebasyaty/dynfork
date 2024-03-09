require "./field"

module DynFork::Fields
  # File upload field.
  struct ImageField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ImageField"
    # Html tag: input type="url".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : DynFork::Globals::ImageData?
    # Default file path.
    # <br>
    # _Example: "assets/media/default/noavatar.jpg"_
    getter! default : String?
    # Displays prompt text.
    getter placeholder : String
    # Root directory for storing media files.
    property media_root : String = "assets/media"
    # URL address for the media directory.
    getter media_url : String = "/media"
    # Directory for images inside media directory.
    # <br>
    # _Examples: avatars|photos|images_
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
    # _Example: [{"xs", 150}, {"sm", 300}, {"md", 600}, {"lg", 1200}]_
    getter! thumbnails : Array({String, Int32})?
    # The maximum allowed image size in bytes.
    # NOTE: 1 MB = 1048576 Bytes (in binary).
    getter maxsize : Int64
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 5
    #
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
    # :nodoc:
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter! choices : Nil

    # :nodoc:
    def has_value?; end

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @target_dir : String = "images",
      @thumbnails : Array({String, Int32})? = nil,
      @maxsize : Int64 = 2097152, # 2 MB
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t("allowed_files.interpolation", types: "jpg/jpeg, png and webp"),
      @warning : String = ""
    )
      @input_type = "file"
    end
  end
end
