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
    def base64_to_tempfile(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    )
      @value = DynFork::Globals::FileData.new
      @value.delete = delete
      #
      if base64 = base64
        # Get file extension.
        if filename = filename
          extension = Path[filename].extension
          if extension.empty?
            raise DynFork::Errors::Panic.new("The file `#{filename}` has no extension.")
          end
          # Add original file name.
          @value.name = filename
        end
        # Prepare Base64 content.
        base64.each_char_with_index do |char, index|
          if char == ','
            base64 = base64.delete_at(0, index + 1)
            break
          end
          break if index == 40
        end
        # Create a target file name.
        name = "#{UUID.v4.to_s}#{extension}"
        # Get the current date for the directory name.
        date : String = Time.utc.to_s("%Y-%m-%d")
        # Create path to target file.
        path : String = "#{@media_root}/#{@target_dir}/#{date}/#{name}"
        # Save file in target directory.
        File.write(
          filename: path,
          content: Base64.decode_string(base64),
          perm: File::Permissions.new(0o644)
        )
        # Add paths to target file.
        @value.path = path
        @value.url = "#{@media_url}/#{@target_dir}/#{date}/#{name}"
        # Add file size.
        @value.size = File.size(@value.path)
      end
    end

    # Convert path to a file and save in the target directory.
    def path_to_tempfile(
      path : String? = nil,
      delete : Bool = false
    )
      @value = DynFork::Globals::FileData.new
      @value.delete = delete
    end

    def refrash_val_file_data(val : DynFork::Globals::FileData)
      @value = val
    end
  end
end
