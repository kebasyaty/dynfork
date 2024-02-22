require "./field"

module Crymon::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  struct ChoiceTextField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextField"
    # Sets the value of an element.
    property value : String?
    # Value by default.
    getter default : String?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # The unique value of a field in a collection.
    getter? unique : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
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
      @default : String? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(String, String))? = Array(Tuple(String, String)).new
    ); end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  struct ChoiceTextMultField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultField"
    # Sets the value of an element.
    property value : Array(String)?
    # Value by default.
    getter default : Array(String)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # The unique value of a field in a collection.
    getter? unique : Bool = false
    # Html tag: select multiple.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
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
      @default : Array(String)? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(String, String))? = Array(Tuple(String, String)).new
    ); end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-One.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceTextDynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextDynField"
    # Sets the value of an element.
    property value : String?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # The unique value of a field in a collection.
    getter? unique : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
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
      @choices = Array(Tuple(String, String)).from_json(json)
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceTextMultDynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultDynField"
    # Sets the value of an element.
    property value : Array(String)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
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
      @choices = Array(Tuple(String, String)).from_json(json)
    end
  end
end
