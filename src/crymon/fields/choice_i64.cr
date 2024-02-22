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
    getter? multiple : Bool = false
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter choices : Array(Tuple(Int64, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 4
    #
    # WARNING: Stub
    getter max : Nil
    # WARNING: Stub
    getter min : Nil
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(Int64, String))? = Array(Tuple(Int64, String)).new
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
    getter? multiple : Bool = true
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Html tag: select multiple.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter choices : Array(Tuple(Int64, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 6
    #
    # WARNING: Stub
    getter max : Nil
    # WARNING: Stub
    getter min : Nil
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @default : Array(Int64)? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(Int64, String))? = Array(Tuple(Int64, String)).new
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
    getter? multiple : Bool = false
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter choices : Array(Tuple(Int64, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 5
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
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    ); end

    # To insert data from global storage.
    def json_to_choices(json : String)
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
    getter? multiple : Bool = true
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter choices : Array(Tuple(Int64, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 7
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
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil
    # WARNING: Stub
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = ""
    ); end

    # To insert data from global storage.
    def json_to_choices(json : String)
      @choices = Array(Tuple(Int64, String)).from_json(json)
    end
  end
end
