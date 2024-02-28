require "json"
require "bson"
require "base64"

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
    property size : Float64 = 0
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
    property extension : String?
    # For temporary storage of a file.
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    @tempfile : File?

    def initialize; end

    # filename: _Example: foo.pdf_
    def base64_to_tempfile(base64 : String, filename : String)
      @extension = Path[filename].extension
      @tempfile = File.tempfile("file", ".#{@extension}") do |file|
        file.print Base64.decode_string(base64)
      end
    end

    def path_to_tempfile(path : String)
      unless File.file?(path)
        raise DynFork::Errors::Panic.new("The file `#{path}` does not exist.")
      end
      @extension = Path[path].extension
      @tempfile = File.tempfile("file", ".#{@extension}") do |file|
        file.print File.read(path)
      end
    end
  end

  # Data type for ImageField.
  struct ImageData
    include JSON::Serializable
    include BSON::Serializable

    # Path to file.
    property path : String = ""
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
    # If the file needs to be deleted: delete=true.
    # <br>
    # By default delete=false.
    @[BSON::Field(ignore: true)]
    property? delete : Bool = false
    # File extension.
    # <br>
    # _Examples: png|jpeg|jpg|webp_
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    property extension : String?
    # For temporary storage of an image.
    @[JSON::Field(ignore: true)]
    @[BSON::Field(ignore: true)]
    @tempfile : File?

    def initialize; end

    # filename: _Example: foo.png_
    def base64_to_tempfile(base64 : String, filename : String)
      @extension = Path[filename].extension
      @tempfile = File.tempfile("img", ".#{@extension}") do |file|
        file.print Base64.decode_string(base64)
      end
    end

    def path_to_tempfile(path : String)
      unless File.file?(path)
        raise DynFork::Errors::Panic.new("The file `#{path}` does not exist.")
      end
      @extension = Path[path].extension
      @tempfile = File.tempfile("img", ".#{@extension}") do |file|
        file.print File.read(path)
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
