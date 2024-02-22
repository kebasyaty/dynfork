require "./field"

module Crymon::Fields
  # A field for entering a date and time.
  # <br>
  # _**Formats:** dd-mm-yyyy hh:mm | dd/mm/yyyy hh:mm | dd.mm.yyyy hh:mm |
  # dd-mm-yyyyThh:mm | dd/mm/yyyyThh:mm | dd.mm.yyyyThh:mm |
  # yyyy-mm-dd hh:mm | yyyy/mm/dd hh:mm | yyyy.mm.dd hh:mm |
  # yyyy-mm-ddThh:mm | yyyy/mm/ddThh:mm | yyyy.mm.ddThh:mm_
  struct DateTimeField < Crymon::Fields::Field
    include Crymon::Tools::Date

    # Field type - Structure Name.
    getter field_type : String = "DateTimeField"
    # Html tag: input type="date".
    getter input_type : String = "datetime"
    # Sets the value of an element.
    # <br>
    # _Example: 1970-01-01T00:00_
    property value : String?
    # Value by default.
    # <br>
    # _Example: 1970-01-01T00:00_
    getter default : String?
    # Displays prompt text.
    getter placeholder : String
    # The top value for entering a date and time.
    getter max : String?
    # The lower value for entering a date and time.
    getter min : String?
    # The unique value of a field in a collection.
    getter? unique : Bool
    # Additional explanation for the user.
    getter hint : String
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # WARNING: Stub
    # :nodoc:
    getter regex : Nil
    # WARNING: Stub
    # :nodoc:
    getter regex_err_msg : Nil
    # WARNING: Stub
    # :nodoc:
    getter maxlength : Nil
    # WARNING: Stub
    # :nodoc:
    getter minlength : Nil
    # WARNING: Stub
    # :nodoc:
    getter choices : Nil
    # WARNING: Stub
    # :nodoc:
    getter maxsize : Nil

    def initialize(
      @label : String = "",
      @default : String? = nil,
      @placeholder : String = "",
      @max : String? = nil,
      @min : String? = nil,
      @hide : Bool = false,
      @unique : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = I18n.t(
        "formats.interpolation", samples: "dd-mm-yyyy hh:mm | dd/mm/yyyy hh:mm | " +
                                          "dd.mm.yyyy hh:mm | dd-mm-yyyyThh:mm | " +
                                          "dd/mm/yyyyThh:mm | dd.mm.yyyyThh:mm | " +
                                          "yyyy-mm-dd hh:mm | yyyy/mm/dd hh:mm | " +
                                          "yyyy.mm.dd hh:mm | yyyy-mm-ddThh:mm | " +
                                          "yyyy/mm/ddThh:mm | yyyy.mm.ddThh:mm")
    ); end

    # Get time object from value.
    def time_object : Time?
      self.datetime_parse(@value.as(String)) unless @value.nil?
    end
  end
end
