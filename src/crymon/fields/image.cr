require "./field"

module Crymon
  module Fields
    # File upload field.
    struct ImageField < Fields::Field
      # Field type - Structure Name.
      getter field_type : String = "ImageField"
      # Html tag: input type="url".
      getter input_type : String = "file"
      # Sets the value of an element.
      property value : Crymon::Fields::ImageData | Nil
      # Value by default.
      property default : Crymon::Fields::ImageData | Nil
      # Displays prompt text.
      property placeholder : String
      # Root directory for storing media files.
      property media_root : String = "../../assets/media"
      # URL address for the media directory.
      property media_url : String = "/media"
      # Directory for files inside media directory (inner path).
      # NOTE: Example: "files/resume".
      property target_dir : String = "images"
      # HTML attribute: accept.
      # NOTE: Describing which file types to allow.
      # NOTE: Example: "image/jpeg,image/png,image/gif"
      # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
      property accept : String = ""
      # From one to four inclusive.
      # NOTE: Example: [{"xs", 150},{"sm", 300},{"md", 600},{"lg", 1200}].
      # NOTE: An Intel i7-4770 processor or better is recommended.
      property thumbnails : Array({String, UInt32}) = Array({String, UInt32}).new
      # Thumbnail quality level: - Fast=false or Qualitatively=true.
      # NOTE: By default: true.
      property is_quality : Bool = true
      # The unique value of a field in a collection.
      property is_unique : Bool
      # To optimize field traversal in the `paladins/check()` method.
      # WARNING: It is recommended not to change.
      getter group : UInt8 = 9

      def initialize(
        @label : String = "",
        @default : Crymon::Fields::ImageData | Nil = nil,
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

      # Check for variable existence.
      def []?(variable) : Bool
        {% for var in @type.instance_vars %}
          if {{ var.name.stringify }} == variable
              return true
          end
        {% end %}
        false
      end
    end
  end
end
