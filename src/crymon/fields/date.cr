require "./field"

module Crymon::Fields
  # A field for entering a date.
  # <br>
  # _**Formats:** dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy |
  # yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd_
  struct DateField < Crymon::Fields::Field
    include Crymon::Tools::Date

    # Field type - Structure Name.
    getter field_type : String = "DateField"
    # Html tag: input type="date".
    getter input_type : String = "date"
    # Sets the value of an element.
    # <br>
    # _Example: 1970-01-01_
    property value : String?
    # Value by default.
    # <br>
    # _Example: 1970-01-01_
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The top value for entering a date.
    getter max : String?
    # The lower value for entering a date.
    getter min : String?
    # The unique value of a field in a collection.
    getter? is_unique : Bool
    # Additional explanation for the user.
    getter hint : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # WARNING: Stub
    getter regex : Nil
    # WARNING: Stub
    getter regex_err_msg : Nil
    # WARNING: Stub
    getter maxlength : Nil
    # WARNING: Stub
    getter minlength : Nil

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @max : String? = nil,
      @min : String? = nil,
      @is_hide : Bool = false,
      @is_unique : Bool = false,
      @is_required : Bool = false,
      @is_disabled : Bool = false,
      @is_readonly : Bool = false,
      @is_ignored : Bool = false,
      @other_attrs : String = "",
      @css_classes : String = "",
      @hint : String = I18n.t(
        "formats.interpolation", samples: "dd-mm-yyyy | dd/mm/yyyy | " +
                                          "dd.mm.yyyy | yyyy-mm-dd | " +
                                          "yyyy/mm/dd | yyyy.mm.dd")
    ); end

    # Get time object from value.
    def get_time_object : Time?
      self.date_parse(@value.as(String)) unless @value.nil?
    end
  end
end
