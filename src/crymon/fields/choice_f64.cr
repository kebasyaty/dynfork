require "./field"

module Crymon::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  struct ChoiceF64Field < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceF64Field"
    # Sets the value of an element.
    property value : Float64?
    # Value by default.
    getter default : Float64?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{5.0, "Title"}, {5.25, "Title 2"}]_
    getter choices : Array(Tuple(Float64, String))?
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
      @default : Float64? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(Float64, String))? = Array(Tuple(Float64, String)).new
    ); end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      value : Float64? = @value || @default
      if !value.nil? && !@choices.nil?
        value_list : Array(Float64) = @choices.not_nil!.map { |item| item[0] }
        return false unless value_list.includes?(value.not_nil!)
      end
      true
    end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  struct ChoiceF64MultField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceF64MultField"
    # Sets the value of an element.
    property value : Array(Float64)?
    # Value by default.
    getter default : Array(Float64)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select multiple.
    # <br>
    # _Example: [{5.0, "Title"}, {5.25, "Title 2"}]_
    getter choices : Array(Tuple(Float64, String))?
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
      @default : Array(Float64)? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @choices : Array(Tuple(Float64, String))? = Array(Tuple(Float64, String)).new
    ); end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      value : Array(Float64)? = @value || @default
      if !value.nil? && !@choices.nil?
        value_list : Array(Float64) = @choices.not_nil!.map { |item| item[0] }
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
  struct ChoiceF64DynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceF64DynField"
    # Sets the value of an element.
    property value : Float64?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{5.0, "Title"}, {5.25, "Title 2"}]_
    getter choices : Array(Tuple(Float64, String))?
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
      @choices = Array(Tuple(Float64, String)).from_json(json)
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      value : Float64? = @value || @default
      if !value.nil? && !@choices.nil?
        value_list : Array(Float64) = @choices.not_nil!.map { |item| item[0] }
        return false unless value_list.includes?(value.not_nil!)
      end
      true
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceF64MultDynField < Crymon::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceF64MultDynField"
    # Sets the value of an element.
    property value : Array(Float64)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select.
    # <br>
    # _Example: [{5.0, "Title"}, {5.25, "Title 2"}]_
    getter choices : Array(Tuple(Float64, String))?
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
      @choices = Array(Tuple(Float64, String)).from_json(json)
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      value : Array(Float64)? = @value || @default
      if !value.nil? && !@choices.nil?
        value_list : Array(Float64) = @choices.not_nil!.map { |item| item[0] }
        value.not_nil!.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
  end
end
