require "./field"

module DynFork::Fields
  # Type of selective field with static of elements.
  # NOTE: With a single choice.
  struct ChoiceTextField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextField"
    # Sets the value of an element.
    property! value : String?
    # Value by default.
    getter! default : String?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter! choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
    # :nodoc:
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter! input_type : Nil
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

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
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def path_to_file(
      path : String? = nil,
      delete : Bool = false
    ); end

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

    def refrash_val_str(val : String)
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(String) = self.choices.map { |item| item[0] }
        return false unless value_list.includes?(value)
      end
      true
    end
  end

  # Type of selective field with static of elements.
  # NOTE: With multiple choice.
  struct ChoiceTextMultField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultField"
    # Sets the value of an element.
    property! value : Array(String)?
    # Value by default.
    getter! default : Array(String)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select multiple.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter! choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
    # :nodoc:
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter! input_type : Nil
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

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
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def path_to_file(
      path : String? = nil,
      delete : Bool = false
    ); end

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

    def refrash_val_arr_str(val : Array(String))
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(String) = self.choices.map { |item| item[0] }
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
  struct ChoiceTextDynField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextDynField"
    # Sets the value of an element.
    property! value : String?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = false
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter! choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter! default : Nil
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
    # :nodoc:
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter! input_type : Nil
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

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
    def extract_file_data : DynFork::Globals::FileData?; end

    # :nodoc:
    def extract_img_data : DynFork::Globals::ImageData?; end

    # :nodoc:
    def refrash_val_date(val : Time); end

    # :nodoc:
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def path_to_file(
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
      @hint : String = ""
    ); end

    # Add data for dynamic fields from the local `@@meta` cache.
    def choices_from_json(json : String)
      @choices = Array(Tuple(String, String)).from_json(json)
    end

    def refrash_val_str(val : String)
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(String) = self.choices.map { |item| item[0] }
        return false unless value_list.includes?(value)
      end
      true
    end
  end

  # Type of selective field with dynamic addition of elements.
  # NOTE: For simulate relationship Many-to-Many.
  # NOTE: Elements are added via the `ModelName.update_dyn_field()` method.
  struct ChoiceTextMultDynField < DynFork::Fields::Field
    # Field type - Structure Name.
    getter field_type : String = "ChoiceTextMultDynField"
    # Sets the value of an element.
    property! value : Array(String)?
    # Specifies that multiple options can be selected at once.
    getter? multiple : Bool = true
    # Html tag: select.
    # <br>
    # _Example: [{"value", "Title"}, {"value 2", "Title 2"}]_
    getter! choices : Array(Tuple(String, String))?
    # To optimize field traversal in the `paladins/check()` method.
    # WARNING: It is recommended not to change.
    getter group : UInt8 = 3
    #
    # :nodoc:
    getter! default : Nil
    # :nodoc:
    getter! max : Nil
    # :nodoc:
    getter! min : Nil
    # :nodoc:
    getter! regex : Nil
    # :nodoc:
    getter! regex_err_msg : Nil
    # :nodoc:
    getter! maxlength : Nil
    # :nodoc:
    getter! minlength : Nil
    # :nodoc:
    getter maxsize : Float32 = 0
    # :nodoc:
    getter? unique : Bool = false
    # :nodoc:
    getter! input_type : Nil
    # :nodoc:
    getter media_root : String = ""
    # :nodoc:
    getter media_url : String = ""
    # :nodoc:
    getter target_dir : String = ""
    # :nodoc:
    getter! thumbnails : Nil

    # :nodoc:
    def refrash_val_i64(val : Int64); end

    # :nodoc:
    def refrash_val_f64(val : Float64); end

    # :nodoc:
    def refrash_val_bool(val : Bool); end

    # :nodoc:
    def refrash_val_str(val : String); end

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
    def extract_val_bool? : Bool?; end

    # :nodoc:
    def extract_default_bool? : Bool?; end

    # :nodoc:
    def base64_to_file(
      base64 : String? = nil,
      filename : String? = nil,
      delete : Bool = false
    ); end

    # :nodoc:
    def path_to_file(
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
      @hint : String = ""
    ); end

    # Add data for dynamic fields from the local `@@meta` cache.
    def choices_from_json(json : String)
      @choices = Array(Tuple(String, String)).from_json(json)
    end

    def refrash_val_arr_str(val : Array(String))
      @value = val
    end

    # Does the field value match the possible options in choices.
    def has_value? : Bool
      if value = @value || @default
        if @choices.nil?
          msg = "Field type: `#{@field_type}` => The `choices` parameter cannot be Nil."
          raise DynFork::Errors::Panic.new msg
        end
        value_list : Array(String) = self.choices.map { |item| item[0] }
        value.each do |elem|
          return false unless value_list.includes?(elem)
        end
      end
      true
    end
  end
end
