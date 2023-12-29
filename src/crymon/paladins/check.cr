require "./groups/*"

# Validation of Model data before saving to the database.
module Crymon::Paladins::Check
  include Crymon::Paladins::Groups

  # Check data validity.
  # NOTE: The main use is to check data from web forms.
  def is_valid : Bool
    self.check.is_valid
  end

  # Printing errors to the console ( for development ).
  def print_err
    msg : String = ""
    errors : String = ""
    {% for field in @type.instance_vars %}
      unless @{{ field }}.errors.empty?
        (msg = "\nERRORS:") if msg.empty?
        errors = @{{ field }}.errors.join(" | ")
        msg = "#{msg}\n#{{{ field.name.stringify }}}: #{errors}"
      end
    {% end %}
    (msg + "\n\n") unless msg.empty?
    puts msg
  end

  # Validation of Model data.
  private def check(
    is_save : Bool = false,
    is_slug_update : Bool = false
  ) : Crymon::Tools::Check::OutputData
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
    is_error_symptom_ptr : Pointer(Bool) = pointerof(is_error_symptom)
    # Errors from additional validation of fields.
    error_map : Hash(String, String) = self.add_validation
    # Data to save or update to the database.
    db_data_bson : BSON = BSON.new
    # Current error message.
    err_msg : String?

    # Check the conditions and, if necessary, define a message for the web form.
    unless is_slug_update
      # Reset the alerts to exclude duplicates.
      @hash.alerts = Array(String).new
      if is_save
        if !is_updated && !metadata[:is_saving_docs]
          @hash.alerts << "It is forbidden to perform saves!"
          is_error_symptom = true
        end
        if is_updated && !metadata[:is_updating_docs]
          @hash.alerts << "It is forbidden to perform updates!"
          is_error_symptom = true
        end
      end
    end

    # Start checking all fields.
    {% for field in @type.instance_vars %}
      # Reset a field errors to exclude duplicates.
      @{{ field }}.errors = Array(String).new
      # Check additional validation.
      if err_msg = error_map[{{ field.name.stringify }}]?
          @{{ field }}.errors << err_msg.to_s
          (is_error_symptom = true) unless is_error_symptom
      end
      #
      unless @{{ field }}.is_ignored
        case @{{ field }}.group
        when 1
          # Validation of `text` type fields:
          # <br>
          # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
          # | "TextField" | "HashField" | "URLField" | "IPField"_
          self.group_1(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 2
          # Validation of `slug` type fields:
          # <br>
          # "SlugField"
          self.group_2(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 3
          # Validation of `date` type fields:
          # <br>
          # "DatField" | "DateTimeField"
          self.group_3(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 4
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextField" | "ChoiceU32Field"
          # | "ChoiceI64Field" | "ChoiceF64Field"
          self.group_4(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 5
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextDynField" | "ChoiceU32DynField"
          # | "ChoiceI64DynField" | "ChoiceF64DynField"
          self.group_5(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 6
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultField" | "ChoiceU32MultField"
          # | "ChoiceI64MultField" | "ChoiceF64MultField"
          self.group_6(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 7
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultDynField" | "ChoiceU32MultDynField"
          # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"
          self.group_7(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 8
          # Validation of `file` type fields:
          # <br>
          # "FileField"
          self.group_8(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 9
          # Validation of `file` type fields:
          # <br>
          # "ImageField"
          self.group_9(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 10
          # Validation of `number` type fields:
          # <br>
          # "U32Field" | "I64Field"
          self.group_10(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 11
          # Validation of `number` type fields:
          # <br>
          # "F64Field"
          self.group_11(
            pointerof(@{{ field }}),
            is_error_symptom_ptr,
            is_updated
          )
        when 12
          # Validation of `boolean` type fields:
          # <br>
          # "BoolField"
          self.group_12(
            pointerof(@{{ field }}),
            is_updated
          )
        else
          raise Crymon::Errors::InvalidGroupNumber
            .new(model_name, {{ field.name.stringify }})
        end
      end
    {% end %}
    #
    # --------------------------------------------------------------------------
    Crymon::Tools::Check::OutputData.new(db_data_bson, !is_error_symptom)
  end
end
