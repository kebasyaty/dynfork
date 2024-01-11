require "./field"

module Crymon::Fields
  # This type was created specifically for the hash field.
  struct HashField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "HashField"
    # Html tag: input type="url".
    getter input_type : String = "text"
    # Sets the value of an element.
    property value : String?
    # Displays prompt text.
    getter placeholder : String
    # The maximum number of characters allowed in the text.
    getter maxlength : Int32?
    # The minimum number of characters allowed in the text.
    getter minlength : Int32?
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Hide field from user.
    property? is_hide : Bool
    # Alerts for the entire web form.
    # WARNING: Assigned automatically.
    property alerts : Array(String) = Array(String).new
    # To optimize field traversal in the `paladins/check` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 1
    #
    # WARNING: Stub
    getter default : Nil
    # WARNING: Stub
    getter max : Nil
    # WARNING: Stub
    getter min : Nil
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    property choices : Nil

    def initialize(
      @label : String = "Hash ID",
      @placeholder : String = "Enter the Document ID for MongoDB",
      @maxlength : Int32? = 24,
      @minlength : Int32? = 24,
      @is_hide : Bool = true,
      @is_unique : Bool = true,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "For enter a document ID"
    ); end

    # Get ObjectId from value.
    def get_object_id : BSON::ObjectId?
      BSON::ObjectId.new(@value.not_nil!) unless @value.nil?
    end
  end
end
