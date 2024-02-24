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
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter regex : Nil
    # :nodoc:
    getter regex_err_msg : Nil
    # :nodoc:
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter maxsize : Nil
    # :nodoc:
    getter? unique : Bool = false

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(String, String))? = Array(Tuple(String, String)).new
    ); end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        value_list : Array(String) = @choices.not_nil!.map { |item| item[0] }
        return false unless value_list.includes?(value.not_nil!)
      end
      true
    end
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
    # Html tag: select multiple.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter max : Nil
    # :nodoc:
    getter min : Nil
    # :nodoc:
    getter regex : Nil
    # :nodoc:
    getter regex_err_msg : Nil
    # :nodoc:
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter maxsize : Nil
    # :nodoc:
    getter? unique : Bool = false

    def initialize(
      @label : String = "",
      @default : Array(String)? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(String, String))? = Array(Tuple(String, String)).new
    ); end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        value_list : Array(String) = @choices.not_nil!.map { |item| item[0] }
        value.not_nil!.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
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
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
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
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter maxsize : Nil
    # :nodoc:
    getter? unique : Bool = false

    def initialize(
      @label : String = "",
      @hide : Bool = false,
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

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        value_list : Array(String) = @choices.not_nil!.map { |item| item[0] }
        return false unless value_list.includes?(value.not_nil!)
      end
      true
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
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
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
    getter maxlength : Nil
    # :nodoc:
    getter minlength : Nil
    # :nodoc:
    getter maxsize : Nil
    # :nodoc:
    getter? unique : Bool = false

    def initialize(
      @label : String = "",
      @hide : Bool = false,
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

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        value_list : Array(String) = @choices.not_nil!.map { |item| item[0] }
        value.not_nil!.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
  end
end
