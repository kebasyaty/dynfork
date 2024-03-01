# Global data types.
module DynFork::Globals::Types
  # Output data type for the `Model.check()` method.
  struct OutputData
    getter data : BSON
    getter? valid : Bool

    def initialize(@data : BSON, @valid : Bool); end
  end

  # Data type for FileField.
  struct FileData
    include JSON::Serializable
    include BSON::Serializable

    # Path to file.
    property path : String = ""
    # URL to the file.
    property url : String = ""
    # File name.
    property name : String = ""
    # File size in bytes.
    getter size : Int64 = 0
    # If the file needs to be deleted: delete=true.
    # <br>
    # By default delete=false.
    @[BSON::Field(ignore: true)]
    property? delete : Bool = false
    # File extension.
    # <br>
    # _Examples: pdf|doc|docx_
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    getter extension : String?
    # For temporary storage of a file.
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    getter tempfile : File?

    def initialize; end

    # filename: _Example: foo.pdf_
    def base64_to_tempfile(base64 : String, filename : String)
      extension = Path[filename].extension
      if extension.empty?
        raise DynFork::Errors::Panic.new("Extension of file does not exist.")
      end
      @extension = extension
      prefix : String = UUID.v4.to_s
      @name = "#{prefix}.#{extension}"
      @tempfile = File.tempfile(
        prefix: "#{prefix}_",
        suffix: ".#{@extension}",
        dir: "tmp"
      ) do |file|
        file.print Base64.decode_string(base64)
      end
      @size = File.size(@tempfile.path)
    end

    def path_to_tempfile(path : String)
      extension = Path[path].extension
      if extension.empty?
        raise DynFork::Errors::Panic.new("Extension of image does not exist.")
      end
      @extension = extension
      content : String = File.read(path)
      prefix : String = UUID.v4.to_s
      @name = "#{prefix}.#{extension}"
      @tempfile = File.tempfile(
        prefix: "#{prefix}_",
        suffix: ".#{@extension}",
        dir: "tmp"
      ) do |file|
        file.print content
      end
      @size = File.size(@tempfile.path)
    end

    def delete_tempfile
      unless @tempfile.nil?
        @tempfile.delete
        @tempfile = Nil
      end
    end
  end

  # Data type for ImageField.
  struct ImageData
    include JSON::Serializable
    include BSON::Serializable

    # Path to image.
    property path : String = ""
    property path_xs : String = ""
    property path_sm : String = ""
    property path_md : String = ""
    property path_lg : String = ""
    # URL to the image.
    property url : String = ""
    property url_xs : String = ""
    property url_sm : String = ""
    property url_md : String = ""
    property url_lg : String = ""
    # Image name (for original image).
    property name : String = ""
    # Image width in pixels (for original image).
    property width : Int32 = 0
    # Image height in pixels (for original image).
    property height : Int32 = 0
    # Image size in bytes (for original image).
    getter size : Int64 = 0
    # If the files needs to be deleted: delete=true.
    # <br>
    # By default delete=false.
    @[BSON::Field(ignore: true)]
    property? delete : Bool = false
    # File extension.
    # <br>
    # _Examples: png|jpeg|jpg|webp_
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    getter extension : String?
    # For temporary storage of an image.
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    getter tempfile : File?
    # The name of the target directory for
    # the original image and its thumbnails.
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    getter target_dir : String?

    def initialize; end

    # filename: _Example: foo.png_
    def base64_to_tempfile(base64 : String, filename : String)
      extension = Path[filename].extension
      if extension.empty?
        raise DynFork::Errors::Panic.new("Extension of image does not exist.")
      end
      @extension = extension
      @name = "original.#{extension}"
      prefix : String = UUID.v4.to_s
      @target_dir = prefix
      @tempfile = File.tempfile(
        prefix: "#{prefix}_",
        suffix: ".#{@extension}",
        dir: "tmp"
      ) do |file|
        file.print Base64.decode_string(base64)
      end
      @size = File.size(@tempfile.path)
    end

    def path_to_tempfile(path : String)
      extension = Path[path].extension
      if extension.empty?
        raise DynFork::Errors::Panic.new("Extension of image does not exist.")
      end
      @extension = extension
      content : String = File.read(path)
      prefix : String = UUID.v4.to_s
      @target_dir = prefix
      @tempfile = File.tempfile(
        prefix: "#{prefix}_",
        suffix: ".#{extension}",
        dir: "tmp"
      ) do |file|
        file.print content
      end
      @size = File.size(@tempfile.path)
    end

    def delete_tempfile
      unless @tempfile.nil?
        @tempfile.delete
        @tempfile = Nil
      end
    end
  end

  # Validation global DynFork settings.
  struct ValidationCacheSettings
    def self.validation
      self.valid_app_name DynFork::Globals.cache_app_name
      self.valid_unique_app_key DynFork::Globals.cache_unique_app_key
      if DynFork::Globals.cache_database_name.empty?
        app_name = DynFork::Globals.cache_app_name
        unique_app_key = DynFork::Globals.cache_unique_app_key
        DynFork::Globals.cache_database_name = "#{app_name}_#{unique_app_key}"
      else
        self.valid_database_name DynFork::Globals.cache_database_name
      end
    end

    # App name = Project name.
    # WARNING: Maximum 44 characters.
    # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/
    def self.valid_app_name(app_name : String)
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "cache_app_name", 44
      ) if app_name.size > 44
      unless DynFork::Globals.cache_regex[:app_name].matches?(app_name)
        raise DynFork::Errors::Cache::SettingsRegexFails.new(
          "cache_app_name",
          "/^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/"
        )
      end
    end

    # Unique project key.
    # WARNING: Match regular expression: /^[a-zA-Z0-9]{16}$/
    def self.valid_unique_app_key(unique_app_key : String)
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "cache_unique_app_key", 16
      ) if unique_app_key.size > 16
      unless DynFork::Globals.cache_regex[:unique_app_key].matches?(unique_app_key)
        raise DynFork::Errors::Cache::SettingsRegexFails.new(
          "cache_unique_app_key",
          "/^[a-zA-Z0-9]{16}$/"
        )
      end
    end

    # Database name.
    # WARNING: Maximum 60 characters.
    def self.valid_database_name(database_name : String)
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "cache_database_name", 60
      ) if database_name.size > 60
    end
  end
end
