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

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_i64(val : Array(Int64)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def extract_file_data? : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def extract_val_i64? : Int64?; end

    # :nodoc:
    def extract_default_i64? : Int64?; end

    # :nodoc:
    def extract_val_f64? : Float64?; end

    # :nodoc:
    def extract_default_f64? : Float64?; end

    # :nodoc:
    def extract_file_path? : String?; end

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

    # Convert base64 to a image and save in the target directory.
    # filename: _Example: foo.pdf_
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    )
      value = DynFork::Globals::ImageData.new
      value.delete = delete
      #
      unless base64.nil?
        # Get image extension.
        extension : String = Path[filename].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The image `#{filename}` has no extension.")
        end
        # Prepare Base64 content.
        base64.each_char_with_index do |char, index|
          if char == ','
            base64 = base64.delete_at(0, index + 1)
            break
          end
          break if index == 40
        end
        #
        uuid : String = UUID.v4.to_s
        # Create current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target directory with images.
        images_dir_path : String = "#{@media_root}/#{@target_dir}/#{date}/#{uuid}"
        # Create url path to target directory with images.
        images_dir_url : String = "#{@media_url}/#{@target_dir}/#{date}/#{uuid}"
        # Create target image name.
        target_img_name = "original#{extension}"
        # Create path to target image.
        target_path : String = "#{images_dir_path}/#{target_img_name}"
        # Create the target directory if it does not exist.
        unless Dir.exists?(images_dir_path)
          Dir.mkdir_p(path: images_dir_path, mode: 0o777)
        end
        # Save image in target directory.
        File.write(
          filename: target_path,
          content: Base64.decode_string(base64),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target image.
        value.path = target_path
        value.url = "#{images_dir_url}/#{target_img_name}"
        # Add original image name.
        value.name = File.basename(path)
        # Add image extension.
        value.extension = extension
        # Add path to target directory with images.
        value.images_dir_path = images_dir_path
        # Add url path to target directory with images.
        value.images_dir_url = images_dir_url
        # Add image size.
        value.size = File.size(path)
      end
      @value = value
    end

    # Convert path to a image and save in the target directory.
    def from_path(
      path : String? = nil,
      delete : Bool = false
    )
      value = DynFork::Globals::ImageData.new
      value.delete = delete
      #
      unless path.nil?
        # Get file extension.
        extension = Path[path].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The image `#{path}` has no extension.")
        end
        #
        uuid : String = UUID.v4.to_s
        # Create current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target directory with images.
        images_dir_path : String = "#{@media_root}/#{@target_dir}/#{date}/#{uuid}"
        # Create url path to target directory with images.
        images_dir_url : String = "#{@media_url}/#{@target_dir}/#{date}/#{uuid}"
        # Create target image name.
        target_img_name = "original#{extension}"
        # Create path to target image.
        target_path : String = "#{images_dir_path}/#{target_img_name}"
        # Create the target directory if it does not exist.
        unless Dir.exists?(images_dir_path)
          Dir.mkdir_p(path: images_dir_path, mode: 0o777)
        end
        # Save image in target directory.
        File.write(
          filename: target_path,
          content: File.read(path),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target image.
        value.path = target_path
        value.url = "#{images_dir_url}/#{target_img_name}"
        # Add original image name.
        value.name = File.basename(path)
        # Add image extension.
        value.extension = extension
        # Add path to target directory with images.
        value.images_dir_path = images_dir_path
        # Add url path to target directory with images.
        value.images_dir_url = images_dir_url
        # Add image size.
        value.size = File.size(path)
      end
      @value = value
    end

    def refrash_val_img_data(val : DynFork::Globals::ImageData) : Void
      @value = val
    end

    def extract_img_data? : DynFork::Globals::ImageData?
      @value
    end

    def extract_images_dir_path? : String?
      @value.images_dir_path? unless @value.nil?
    end
  end
end
