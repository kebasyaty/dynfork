require "./field"

module Fields
  # Boolean field.
  struct BoolField < Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "BoolField"
    # Field type - Html, input type.
    getter input_type : String = "checkbox"
    # Sets the value of an element.
    property value : Bool | Nil
    # Value by default.
    property default : Bool | Nil
    # To optimize field traversal in the `paladins/check()` method.
    # Hint: It is recommended not to change.
    getter group : UInt32 = 13

    def initialize(
      @label : String = "",
      @default : Bool | Nil = false,
      @is_hide : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = ""
    ); end
  end
end
