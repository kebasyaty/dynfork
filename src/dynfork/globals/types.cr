# Global data types.
module DynFork::Globals::Types
  # Output data type for the `Model.check()` method.
  struct OutputData
    include JSON::Serializable
    include BSON::Serializable

    getter data : Hash(String, DynFork::Globals::ResultMapType)
    property? valid : Bool
    getter? update : Bool

    def initialize(
      @data : Hash(String, DynFork::Globals::ResultMapType),
      @valid : Bool,
      @update : Bool
    ); end
  end

  # Unit of information for `choices` parameter in dynamic field types.
  struct Unit
    include JSON::Serializable
    include JSON::Serializable::Strict

    getter! field : String
    getter! title : String
    getter! value : Float64 | Int64 | String
    getter? delete : Bool

    def initialize(
      @field : String,
      @title : String,
      @value : Float64 | Int64 | String,
      @delete : Bool = false
    ); end
  end

  # Data type for FileField.
  struct FileData
    include JSON::Serializable
    include BSON::Serializable

    # Path to file.
    property path : String = ""
    # URL to file.
    property url : String = ""
    # Original file name.
    property name : String = ""
    # File size in bytes.
    property size : Int64 = 0
    # If the file needs to be deleted: _delete=true_.
    # <br>
    # **By default:** _delete=false_.
    property? delete : Bool = false
    # File extension.
    # <br>
    # **Examples:** _.txt|.xml|.doc|.svg_
    property extension : String = ""

    def initialize; end
  end

  # Data type for ImageField.
  struct ImageData
    include JSON::Serializable
    include BSON::Serializable

    # Path to image (_for original image_).
    property path : String = ""
    # For thumbnails.
    property path_xs : String = ""
    property path_sm : String = ""
    property path_md : String = ""
    property path_lg : String = ""
    # URL to the image (_for original image_).
    property url : String = ""
    # For thumbnails.
    property url_xs : String = ""
    property url_sm : String = ""
    property url_md : String = ""
    property url_lg : String = ""
    # Image name (_for original image_).
    property name : String = ""
    # Image width in pixels (_for original image_).
    property width : Int32 = 0
    # Image height in pixels (_for original image_).
    property height : Int32 = 0
    # Image size in bytes (_for original image_).
    property size : Int64 = 0
    # If the images needs to be deleted: _delete=true_.
    # <br>
    # **By default:** _delete=false_.
    property? delete : Bool = false
    # Image extension.
    # <br>
    # **Examples:** _.png|.jpeg|.jpg|.webp_
    property extension : String = ""
    # Path to target directory with images.
    property! images_dir_path : String?
    # URL path to target directory with images.
    property! images_dir_url : String?

    def initialize; end
  end

  # Validation global DynFork settings.
  struct ValidationCacheSettings
    def self.validation : Nil
      self.valid_app_name DynFork::Globals.app_name
      self.valid_unique_app_key DynFork::Globals.unique_app_key
      if DynFork::Globals.database_name.empty?
        app_name = DynFork::Globals.app_name
        unique_app_key = DynFork::Globals.unique_app_key
        DynFork::Globals.database_name = "#{app_name}_#{unique_app_key}"
      else
        self.valid_database_name DynFork::Globals.database_name
      end
    end

    # App name = Project name.
    # WARNING: Maximum 44 characters.
    # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/
    def self.valid_app_name(app_name : String) : Nil
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "app_name", 44
      ) if app_name.size > 44
      unless DynFork::Globals.regex[:app_name].matches?(app_name)
        raise DynFork::Errors::Cache::SettingsRegexFails.new(
          "app_name",
          "/^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/"
        )
      end
    end

    # Unique project key.
    # WARNING: Match regular expression: /^[a-zA-Z0-9]{16}$/
    def self.valid_unique_app_key(unique_app_key : String) : Nil
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "unique_app_key", 16
      ) if unique_app_key.size > 16
      unless DynFork::Globals.regex[:unique_app_key].matches?(unique_app_key)
        raise DynFork::Errors::Cache::SettingsRegexFails.new(
          "unique_app_key",
          "/^[a-zA-Z0-9]{16}$/"
        )
      end
    end

    # Database name.
    # WARNING: Maximum 60 characters.
    def self.valid_database_name(database_name : String) : Nil
      raise DynFork::Errors::Cache::SettingsExcessChars.new(
        "database_name", 60
      ) if database_name.size > 60
    end
  end
end
