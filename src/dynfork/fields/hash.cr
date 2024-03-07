require "./field"

module DynFork::Fields
  # This type was created specifically for the hash field.
  struct HashField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "HashField"
    # Html tag: input type="url".
    getter input_type : String = "text"
    # Sets the value of an element.
    property value : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : UInt32?
    # The minimum number of characters allowed in the text.
    getter minlength : UInt32?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Hide field from user.
    property? hide : Bool
    # Alerts for the entire web form.
    # WARNING: Assigned automatically.
    property alerts : Array(String) = Array(String).new
    # To optimize field traversal in the `paladins/check` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # :nodoc:
    getter default : Nil
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter regex : Nil
    # :nodoc:
    getter regex_err_msg : Nil
    # :nodoc:
    getter choices : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter thumbnails : Nil

    # :nodoc:
    def has_value?; end

    def initialize(
      @label : String = "Document ID",
      @placeholder : String = "Enter document ID",
      @maxlength : UInt32? = 24,
      @minlength : UInt32? = 24,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "For enter a document ID."
    ); end

    # Get ObjectId from value.
    def object_id : BSON::ObjectId?
      BSON::ObjectId.new(@value.not_nil!) unless @value.nil?
    end
  end
end
