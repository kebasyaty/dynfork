require "./groups/*"

# Validation of Model data before saving to the database.
module Crymon::Paladins::Check
  include Crymon::Paladins::Groups

  # Output data for the Save method.
  struct OutputData
    getter data : BSON
    getter is_valid : Bool

    def initialize(@data : BSON, @is_valid : Bool); end
  end

  # Check data validity.
  # NOTE: The main use is to check data from web forms.
  def is_valid : Bool
    self.check.is_valid
  end

  # Validation of Model data.
  private def check(
    is_save : Bool = false,
    is_slug_update : Bool = false
  ) : OutputData
    # Get model key.
    model_key : String = self.model_key
    # Get metadata of Model from cache.
    metadata : Crymon::Globals::CacheMetaDataType = Crymon::Globals.cache_metadata[model_key]
    # Get model name.
    model_name : String = metadata[:model_name]
    # Does the document exist in the database?
    is_updated : Bool = !@hash.value.nil?
    # Is there any incorrect data?
    is_error_symptom : Bool = false
    # Errors from additional validation of fields.
    error_map : Hash(String, String) = self.add_validation
    # Data to save or update to the database.
    db_data_bson : BSON = BSON.new
    # Current error message.
    err_msg : String?

    # Check the conditions and, if necessary, define a message for the web form.
    unless is_slug_update
      @hash.alert = Array(String).new
      if is_save
        if !is_updated && !metadata[:is_saving_docs]
          @hash.alert << "It is forbidden to perform saves!"
        end
        if is_updated && !metadata[:is_updating_docs]
          @hash.alert << "It is forbidden to perform updates!"
        end
      end
    end

    # Start checking all fields.
    {% for field in @type.instance_vars %}
      @{{ field }}.errors = Array(String).new
      # Check additional validation.
      if err_msg = error_map[{{ field.name.stringify }}]?
          @{{ field }}.errors << err_msg.to_s
          is_error_symptom = true
      end
      #
      unless @{{ field }}.is_ignored
        case @{{ field }}.group
        when 1
          # Validation of `text` type fields:
          # <br>
          # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
          # | "TextField" | "HashField" | "URLField" | "IPField"_
          (is_error_symptom = true) if self.group_1(pointerof(@{{ field }}))
        when 2
          # Validation of `slug` type fields:
          # <br>
          # "SlugField"
          (is_error_symptom = true) if self.group_2(pointerof(@{{ field }}))
        when 3
          # Validation of `date` type fields:
          # <br>
          # "DatField" | "DateTimeField"
          (is_error_symptom = true) if self.group_3(pointerof(@{{ field }}))
        when 4
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextField" | "ChoiceU32Field"
          # | "ChoiceI64Field" | "ChoiceF64Field"
          (is_error_symptom = true) if self.group_4(pointerof(@{{ field }}))
        when 5
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextDynField" | "ChoiceU32DynField"
          # | "ChoiceI64DynField" | "ChoiceF64DynField"
          (is_error_symptom = true) if self.group_5(pointerof(@{{ field }}))
        when 6
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultField" | "ChoiceU32MultField"
          # | "ChoiceI64MultField" | "ChoiceF64MultField"
          (is_error_symptom = true) if self.group_6(pointerof(@{{ field }}))
        when 7
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultDynField" | "ChoiceU32MultDynField"
          # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"
          (is_error_symptom = true) if self.group_7(pointerof(@{{ field }}))
        when 8
          # Validation of `file` type fields:
          # <br>
          # "FileField"
          (is_error_symptom = true) if self.group_8(pointerof(@{{ field }}))
        when 9
          # Validation of `file` type fields:
          # <br>
          # "ImageField"
          (is_error_symptom = true) if self.group_9(pointerof(@{{ field }}))
        when 10
          # Validation of `number` type fields:
          # <br>
          # "U32Field" | "I64Field"
          (is_error_symptom = true) if self.group_10(pointerof(@{{ field }}))
        when 11
          # Validation of `number` type fields:
          # <br>
          # "F64Field"
          (is_error_symptom = true) if self.group_11(pointerof(@{{ field }}))
        when 12
          # Validation of `boolean` type fields:
          # <br>
          # "BoolField"
          (is_error_symptom = true) if self.group_12(pointerof(@{{ field }}))
        else
          raise Crymon::Errors::InvalidGroupNumber
            .new(model_name, {{ field.name.stringify }})
        end
      end
    {% end %}
    #
    # --------------------------------------------------------------------------
    OutputData.new(db_data_bson, !is_error_symptom)
  end
end
