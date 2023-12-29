require "bson"
require "json"

# Auxiliary data types.
module Crymon::Tools::Types
  # Output data type for the `Model.check()` method.
  struct OutputData
    getter data : BSON
    getter is_valid : Bool

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
end
