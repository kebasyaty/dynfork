require "./field"

module DynFork::Fields
  # File upload field.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/files" target="_blank">example</a>.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct FileField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "FileField"
    # Html tag: input type="file".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : DynFork::Globals::FileData?
    # Default file path.
    # NOTE: **Example:** _"public/media/default/nodoc.docx"_
    getter! default : String?
    # Root directory for storing media files.
    getter media_root : String = "public/media/uploads"
    # URL address for the media directory.
    getter media_url : String = "/media/uploads"
    # Directory for files inside media directory.
    # NOTE: **Examples:** _files|resume|reports_
    getter target_dir : String
    # HTML attribute: accept
    # NOTE: Describing which file types to allow.
    # NOTE: **Example:** _".pdf,.doc,.docx,application/msword"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = ""
    # Displays prompt text.
    getter placeholder : String
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # The maximum allowed file size in bytes.
    # NOTE: 1 MB = 1048576 Bytes (in binary).
    getter maxsize : Int64
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! choices : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? multiple : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

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
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @target_dir : String = "files",
      @accept : String = "",
      @placeholder : String = "",
      @maxsize : Int64 = 2097152, # 2 MB
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = Array(String).new,
    )
      @input_type = "file"
    end

    # Convert base64 to a file and save in the target directory.
    # NOTE: `filename` _Example: foo.pdf_
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false,
    ) : Nil
      base64 = base64.presence
      filename = filename.presence
      value = DynFork::Globals::FileData.new
      value.new_file_data = true
      value.delete = delete
      #
      if !base64.nil? && !filename.nil?
        # Get file extension.
        extension = Path[filename.not_nil!].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The file `#{filename}` has no extension.")
        end
        # Prepare Base64 content.
        base64.not_nil!.each_char_with_index do |char, index|
          if char == ','
            base64 = base64.not_nil!.delete_at(0, index + 1)
            break
          end
          break if index == 40
        end
        # Create target file name.
        target_name = "#{UUID.v4}#{extension}"
        # Create the current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target file.
        target_path : String = "#{@media_root}/#{@target_dir}/#{date}"
        # Create target directory if it does not exist.
        unless Dir.exists?(target_path)
          Dir.mkdir_p(path: target_path, mode: 0o777)
        end
        target_path += "/#{target_name}"
        # Save file in target directory.
        File.write(
          filename: target_path,
          content: Base64.decode_string(base64.not_nil!),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target file.
        value.path = target_path
        value.url = "#{@media_url}/#{@target_dir}/#{date}/#{target_name}"
        # Add original file name.
        value.name = filename.not_nil!
        # Add file extension.
        value.extension = extension
        # Add file size.
        value.size = File.size(target_path)
      end
      @value = value
    end

    # Convert path to a file and save in the target directory.
    def from_path(
      path : String? = nil,
      delete : Bool = false,
    ) : Nil
      path = path.presence
      value = DynFork::Globals::FileData.new
      value.new_file_data = true
      value.delete = delete
      #
      unless path.nil?
        # Get file extension.
        extension = Path[path.not_nil!].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The file `#{path}` has no extension.")
        end
        # Create a target file name.
        target_name = "#{UUID.v4}#{extension}"
        # Get the current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target file.
        target_path : String = "#{@media_root}/#{@target_dir}/#{date}"
        # Create the target directory if it does not exist.
        unless Dir.exists?(target_path)
          Dir.mkdir_p(path: target_path, mode: 0o777)
        end
        target_path += "/#{target_name}"
        # Save file in target directory.
        File.write(
          filename: target_path,
          content: File.read(path.not_nil!),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target file.
        value.path = target_path
        value.url = "#{@media_url}/#{@target_dir}/#{date}/#{target_name}"
        # Add original file name.
        value.name = File.basename(path.not_nil!)
        # Add file extension.
        value.extension = extension
        # Add file size.
        value.size = File.size(target_path)
      end
      @value = value
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_file_data(val : DynFork::Globals::FileData) : Nil
      @value = val
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_file_data : DynFork::Globals::FileData?
      @value
    end

    # For the `DynFork::QPaladins::Check#check` method.
    def extract_file_path : String?
      @value.not_nil!.path unless @value.nil?
    end
  end
end
