require "./field"

module DynFork::Fields
  # File upload field.
  struct FileField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "FileField"
    # Html tag: input type="url".
    getter! input_type : String?
    # Sets the value of an element.
    property! value : DynFork::Globals::FileData?
    # Default file path.
    # <br>
    # _Example: "assets/media/default/nodoc.docx"_
    getter! default : String?
    # Root directory for storing media files.
    getter media_root : String = "assets/media"
    # URL address for the media directory.
    getter media_url : String = "/media"
    # Directory for files inside media directory.
    # <br>
    # _Examples: files|resume|reports_
    getter target_dir : String
    # HTML attribute: accept
    # <br>
    # Describing which file types to allow.
    # <br>
    # _Example: ".pdf,.doc,.docx,application/msword"_
    # NOTE: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/accept#unique_file_type_specifiers
    getter accept : String = ""
    # Displays prompt text.
    getter placeholder : String
    # The maximum allowed file size in bytes.
    # NOTE: 1 MB = 1048576 Bytes (in binary).
    getter maxsize : Int64
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
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
    getter! thumbnails : Nil

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

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @target_dir : String = "files",
      @accept : String = "",
      @placeholder : String = "",
      @maxsize : Int64 = 524288, # 0.5 MB
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : String = ""
    )
      @input_type = "file"
    end

    # Convert base64 to a file and save in the target directory.
    # filename: _Example: foo.pdf_
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    )
      value = DynFork::Globals::FileData.new
      value.delete = delete
      #
      unless base64.nil?
        # Get file extension.
        extension = Path[filename].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The file `#{filename}` has no extension.")
        end
        # Prepare Base64 content.
        base64.each_char_with_index do |char, index|
          if char == ','
            base64 = base64.delete_at(0, index + 1)
            break
          end
          break if index == 40
        end
        # Create target file name.
        target_name = "#{UUID.v4}#{extension}"
        # Create the current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target file.
        target_path : String = "#{@media_root}/#{@target_dir}/#{date}/#{target_name}"
        # Create target directory if it does not exist.
        unless Dir.exists?(target_path)
          Dir.mkdir_p(path: target_path, mode: 0o777)
        end
        # Save file in target directory.
        File.write(
          filename: target_path,
          content: Base64.decode_string(base64),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target file.
        value.path = target_path
        value.url = "#{@media_url}/#{@target_dir}/#{date}/#{target_name}"
        # Add original file name.
        value.name = filename.not_nil!
        # Add file size.
        value.size = File.size(@value.path)
      end
      @value = value
    end

    # Convert path to a file and save in the target directory.
    def path_to_file(
      path : String? = nil,
      delete : Bool = false
    )
      value = DynFork::Globals::FileData.new
      value.delete = delete
      #
      unless path.nil?
        # Get file extension.
        extension = Path[path].extension
        if extension.empty?
          raise DynFork::Errors::Panic.new("The file `#{path}` has no extension.")
        end
        # Create a target file name.
        target_name = "#{UUID.v4}#{extension}"
        # Get the current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target file.
        target_path : String = "#{@media_root}/#{@target_dir}/#{date}/#{target_name}"
        # Create the target directory if it does not exist.
        unless Dir.exists?(target_path)
          Dir.mkdir_p(path: target_path, mode: 0o777)
        end
        # Save file in target directory.
        File.write(
          filename: target_path,
          content: File.read(path),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target file.
        value.path = target_path
        value.url = "#{@media_url}/#{@target_dir}/#{date}/#{target_name}"
        # Add original file name.
        value.name = File.basename(path)
        # Add file size.
        value.size = File.size(target_path)
      end
      @value = value
    end

    def refrash_val_file_data(val : DynFork::Globals::FileData)
      @value = val
    end

    def extract_file_data : DynFork::Globals::FileData?
      @value
    end
  end
end
