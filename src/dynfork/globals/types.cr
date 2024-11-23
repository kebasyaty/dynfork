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

  # Data type for `FileField`.
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
    # A sign of a new file.
    # NOTE: true - if there is no file in the database.
    property? new_file_data : Bool = false
    # If the file needs to be deleted: _delete=true_.
    # NOTE: **By default:** _delete=false_.
    property? delete : Bool = false
    # File extension.
    # NOTE: **Examples:** _.txt|.xml|.doc|.svg_
    property extension : String = ""
    # To copy data from a related document and use the same files.
    property? save_as_is : Bool = false

    def initialize; end
  end

  # Data type for `ImageField`.
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
    # A sign of a new image.
    # NOTE: true - if there is no image in the database.
    property? new_img_data : Bool = false
    # If the images needs to be deleted: _delete=true_.
    # NOTE: **By default:** _delete=false_.
    property? delete : Bool = false
    # Image extension.
    # NOTE: **Examples:** _.png|.jpeg|.jpg|.webp_
    property extension : String = ""
    # Path to target directory with images.
    property! images_dir_path : String?
    # URL path to target directory with images.
    property! images_dir_url : String?
    # To copy data from a related document and use the same files.
    property? save_as_is : Bool = false

    def initialize; end
  end
end
