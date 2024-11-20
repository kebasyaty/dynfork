require "./field"

module DynFork::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/static_choices" target="_blank">example</a>.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct ChoiceI64Field < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64Field"
    # Sets the value of an element.
    property! value : Int64?
    # Value by default.
    getter! default : Int64?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter! choices : Array(Tuple(Int64, String))?
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! input_type : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_i64(val : Array(Int64)); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
    ); end

    def initialize(
      @label : String = "",
      @default : Int64? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = Array(String).new,
      @choices : Array(Tuple(Int64, String))? = Array(Tuple(Int64, String)).new
    ); end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_i64(val : Int64) : Nil
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value : Bool
      if value = @value || @default
        value_list : Array(Int64) = self.choices.map { |item| item[0] }
        return false unless value_list.includes?(value)
      end
      true
    end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/static_choices" target="_blank">example</a>.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct ChoiceI64MultField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64MultField"
    # Sets the value of an element.
    property! value : Array(Int64)?
    # Value by default.
    getter! default : Array(Int64)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select multiple.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter! choices : Array(Tuple(Int64, String))?
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! input_type : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
    ); end

    def initialize(
      @label : String = "",
      @default : Array(Int64)? = nil,
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = Array(String).new,
      @choices : Array(Tuple(Int64, String))? = Array(Tuple(Int64, String)).new
    ); end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_arr_i64(val : Array(Int64)) : Nil
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value : Bool
      if value = @value || @default
        value_list : Array(Int64) = self.choices.map { |item| item[0] }
        value.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-One.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/dynamic_choices" target="_blank">example</a>.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct ChoiceI64DynField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64DynField"
    # Sets the value of an element.
    property! value : Int64?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter! choices : Array(Tuple(Int64, String))?
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! default : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! input_type : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_i64(val : Array(Int64)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
    ); end

    def initialize(
      @label : String = "",
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = Array(String).new,
    ); end

    # Add data for dynamic fields from the local `@@meta` cache.
    def choices_from_json(json : String) : Nil
      @choices = Array(Tuple(Int64, String)).from_json(json)
    end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_i64(val : Int64) : Nil
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(Int64) = self.choices.map { |item| item[0] }
        return false unless value_list.includes?(value)
      end
      true
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  # NOTE: How to use, see <a href="https://github.com/kebasyaty/dynfork/tree/main/examples/dynamic_choices" target="_blank">example</a>.
  @[JSON::Serializable::Options(emit_nulls: true)]
  struct ChoiceI64MultDynField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceI64MultDynField"
    # Sets the value of an element.
    property! value : Array(Int64)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select.
    # <br>
    # _Example: [{5, "Title"}, {10, "Title 2"}]_
    getter! choices : Array(Tuple(Int64, String))?
    # Required field.
    getter? required : Bool
    # Specifies that the field cannot be modified by the user.
    property? readonly : Bool
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! default : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! max : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! min : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! regex_err_msg : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! maxlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! minlength : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter maxsize : Float32 = 0

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? unique : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! input_type : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_root : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter media_url : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter target_dir : String = ""

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    getter? use_editor : Bool = false

    # :nodoc:
    @[JSON::Field(ignore: true)]
    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

    # :nodoc:
    def refrash_val_arr_str(val : Array(String)); end

    # :nodoc:
    def refrash_val_arr_f64(val : Array(Float64)); end

    # :nodoc:
    def refrash_val_file_data(val : DynFork::Globals::FileData); end

    # :nodoc:
    def refrash_val_img_data(val : DynFork::Globals::ImageData); end

    # :nodoc:
    def refrash_val_datetime(val : Time); end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def extract_val_bool : Bool?; end

    # :nodoc:
    def extract_default_bool : Bool?; end

    # :nodoc:
    def extract_val_i64 : Int64?; end

    # :nodoc:
    def extract_default_i64 : Int64?; end

    # :nodoc:
    def extract_val_f64 : Float64?; end

    # :nodoc:
    def extract_default_f64 : Float64?; end

    # :nodoc:
    def extract_images_dir_path : String?; end

    # :nodoc:
    def extract_file_path : String?; end

    # :nodoc:
    def from_base64(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def from_path(
      path : String? = nil,
      delete : Bool = false
    ); end

    def initialize(
      @label : String = "",
      @hide : Bool = false,
      @required : Bool = false,
      @disabled : Bool = false,
      @readonly : Bool = false,
      @ignored : Bool = false,
      @hint : String = "",
      @warning : Array(String) = Array(String).new,
    ); end

    # For the `DynFork::QPaladins::Tools#refrash_fields` method.
    def refrash_val_arr_i64(val : Array(Int64)) : Nil
      @value = val
    end

    # Add data for dynamic fields from the local `@@meta` cache.
    def choices_from_json(json : String) : Nil
      @choices = Array(Tuple(Int64, String)).from_json(json)
    end

    # Does the field value match the possible options in choices.
    def has_value : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(Int64) = self.choices.map { |item| item[0] }
        value.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
  end
end
