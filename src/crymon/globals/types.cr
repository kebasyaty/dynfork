require "bson"
require "json"

# Global data types.
module Crymon::Globals::Types
  # Output data type for the `Model.check()` method.
  struct OutputData
    getter data : BSON
    getter? is_valid : Bool

    def initialize(@data : BSON, @is_valid : Bool); end
  end

  # Data type for FileField.
  struct FileData
    include BSON::Serializable
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
    # <br>
    # By default is_delete=false.
    property is_delete : Bool

    def initialize(
      @path : String = "",
      @is_delete : Bool = false
    ); end
  end

  # Data type for ImageField.
  struct ImageData
    include BSON::Serializable
    include JSON::Serializable
    include JSON::Serializable::Strict
    # Path to  file.
    property path : String
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
    # If the file needs to be deleted: is_delete=true.
    # <br>
    # By default is_delete=false.
    property is_delete : Bool

    def initialize(
      @path : String = "",
      @is_delete : Bool = false
    ); end
  end

  # Validation global Crymon settings.
  struct ValidationCacheSettings
    def self.validation
      self.valid_app_name Crymon::Globals.cache_app_name
      self.valid_unique_app_key Crymon::Globals.cache_unique_app_key
      if Crymon::Globals.cache_database_name.empty?
        app_name = Crymon::Globals.cache_app_name
        unique_app_key = Crymon::Globals.cache_unique_app_key
        Crymon::Globals.cache_database_name = "#{app_name}_#{unique_app_key}"
      else
        self.valid_database_name Crymon::Globals.cache_database_name
      end
    end

    # App name = Project name.
    # WARNING: Maximum 44 characters.
    # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/
    def self.valid_app_name(app_name : String)
      raise Crymon::Errors::Cache::SettingsExcessChars.new(
        "cache_app_name", 44
      ) if app_name.size > 44
      unless Crymon::Globals.cache_regex[:app_name].matches?(app_name)
        raise Crymon::Errors::Cache::SettingsRegexFails.new(
          "cache_app_name",
          "/^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/"
        )
      end
    end

    # Unique project key.
    # WARNING: Match regular expression: /^[a-zA-Z0-9]{16}$/
    def self.valid_unique_app_key(unique_app_key : String)
      raise Crymon::Errors::Cache::SettingsExcessChars.new(
        "cache_unique_app_key", 16
      ) if unique_app_key.size > 16
      unless Crymon::Globals.cache_regex[:unique_app_key].matches?(unique_app_key)
        raise Crymon::Errors::Cache::SettingsRegexFails.new(
          "cache_unique_app_key",
          "/^[a-zA-Z0-9]{16}$/"
        )
      end
    end

    # Database name.
    # WARNING: Maximum 60 characters.
    def self.valid_database_name(database_name : String)
      raise Crymon::Errors::Cache::SettingsExcessChars.new(
        "cache_database_name", 60
      ) if database_name.size > 60
    end
  end
end
