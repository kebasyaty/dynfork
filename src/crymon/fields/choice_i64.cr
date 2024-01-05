require "./field"

module Crymon::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  struct ChoiceI64Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64Field"
    # Sets the value of an element.
    property value : Int64?
    # Value by default.
    getter default : Int64?
    # Specifies that multiple options can be selected at once.
    getter? is_multiple : Bool = false
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(Int64, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
    #
    # WARNING: Stubs
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(Int64, String)) = Array(Tuple(Int64, String)).new
    ); end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  struct ChoiceI64MultField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64MultField"
    # Sets the value of an element.
    property value : Array(Int64)?
    # Value by default.
    getter default : Array(String)?
    # Specifies that multiple options can be selected at once.
    getter? is_multiple : Bool = true
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Html tag: select multiple.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(Int64, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 6
    #
    # WARNING: Stubs
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @default : Array(Int64)? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(Int64, String)) = Array(Tuple(Int64, String)).new
    ); end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-One.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceI64DynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64DynField"
    # Sets the value of an element.
    property value : Int64?
    # Specifies that multiple options can be selected at once.
    getter? is_multiple : Bool = false
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(Int64, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 5
    #
    # WARNING: Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(Int64, String)) = Array(Tuple(Int64, String)).new
    ); end

    # To work around the error - undefined method 'choices='.
    def set_choices(json : String)
      @choices = Array(Tuple(Int64, String)).from_json(json)
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceI64MultDynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64MultDynField"
    # Sets the value of an element.
    property value : Array(Int64)?
    # Specifies that multiple options can be selected at once.
    getter? is_multiple : Bool = true
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    property choices : Array(Tuple(Int64, String))
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 7
    #
    # WARNING: Stubs
    getter default : Nil
    getter max : Nil
    getter min : Nil
    getter regex : Nil
    getter regex_err_msg : Nil
    getter maxlength : Nil
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = "",
      @choices : Array(Tuple(Int64, String)) = Array(Tuple(Int64, String)).new
    ); end

    # To work around the error - undefined method 'choices='.
    def set_choices(json : String)
      @choices = Array(Tuple(Int64, String)).from_json(json)
    end
  end
end
