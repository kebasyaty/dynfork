require "./check_plus"
require "./groups/*"

# Validation of Model data before saving to the database.
module Crymon::Paladins::Check
  include Crymon::Paladins::CheckPlus
  include Crymon::Paladins::Groups

  # Validation of Model data.
  def check(
    collection_ptr : Pointer(Mongo::Collection),
    is_save? : Bool = false
  ) : Crymon::Globals::OutputData
    # Does the document exist in the database?
    is_updated? : Bool = !@hash.value.nil? && !@hash.value.not_nil!.empty?
    # Validation the hash field value.
    if is_updated? && !BSON::ObjectId.validate(@hash.value.not_nil!)
      msg = "Model: `#{@@meta.not_nil![:model_name]}` > " +
            "Field: `hash` => The hash field value is not valid."
      raise Crymon::Errors::Panic.new msg
    end
    # Is there any incorrect data?
    is_error_symptom? : Bool = false
    is_error_symptom_ptr? : Pointer(Bool) = pointerof(is_error_symptom?)
    # Errors from additional validation of fields.
    error_map : Hash(String, String) = self.add_validation
    # Data to save or update to the database.
    result_bson : BSON = BSON.new
    result_bson_ptr : Pointer(BSON) = pointerof(result_bson)
    # Current error message.
    err_msg : String?

    # Check the conditions and, if necessary, define a message for the web form.
    # Reset the alerts to exclude duplicates.
    if is_save?
      @hash.alerts = Array(String).new
      if !is_updated? && !@@meta.not_nil![:is_saving_docs]
        @hash.alerts << "It is forbidden to perform saves!"
        is_error_symptom? = true
      end
      if is_updated? && !@@meta.not_nil![:is_updating_docs]
        @hash.alerts << "It is forbidden to perform updates!"
        is_error_symptom? = true
      end
    end

    # Start checking all fields.
    {% for field in @type.instance_vars %}
      # Reset a field errors to exclude duplicates.
      @{{ field }}.errors = Array(String).new
      # Check additional validation.
      if err_msg = error_map[{{ field.name.stringify }}]?
          @{{ field }}.errors << err_msg.not_nil!
          (is_error_symptom? = true) unless is_error_symptom?
          err_msg = nil
      end
      #
      unless @{{ field }}.is_ignored?
        case @{{ field }}.group
        when 1
          # Validation of `text` type fields:
          # <br>
          # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
          # | "TextField" | "HashField" | "URLField" | "IPField"_
          self.group_01(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?,
            is_save?,
            result_bson_ptr,
            collection_ptr
          )
        when 2
          # Ignore validation of `slug` type fields.
          # <br>
          # These fields are checked in the `caching` and `create_slugs` methods.
        when 3
          # Validation of `date` type fields:
          # <br>
          # "DatField" | "DateTimeField"
          self.group_03(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_save?,
            result_bson_ptr,
            collection_ptr
          )
        when 4
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextField" | "ChoiceU32Field"
          # | "ChoiceI64Field" | "ChoiceF64Field"
          self.group_04(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 5
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextDynField" | "ChoiceU32DynField"
          # | "ChoiceI64DynField" | "ChoiceF64DynField"
          self.group_05(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 6
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultField" | "ChoiceU32MultField"
          # | "ChoiceI64MultField" | "ChoiceF64MultField"
          self.group_06(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 7
          # Validation of `choice` type fields:
          # <br>
          # "ChoiceTextMultDynField" | "ChoiceU32MultDynField"
          # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"
          self.group_07(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 8
          # Validation of `file` type fields:
          # <br>
          # "FileField"
          self.group_08(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 9
          # Validation of `file` type fields:
          # <br>
          # "ImageField"
          self.group_09(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 10
          # Validation of `number` type fields:
          # <br>
          # "U32Field" | "I64Field"
          self.group_10(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 11
          # Validation of `number` type fields:
          # <br>
          # "F64Field"
          self.group_11(
            pointerof(@{{ field }}),
            is_error_symptom_ptr?,
            is_updated?
          )
        when 12
          # Validation of `boolean` type fields:
          # <br>
          # "BoolField"
          self.group_12(
            pointerof(@{{ field }}),
            is_updated?
          )
        else
          raise Crymon::Errors::Model::InvalidGroupNumber
            .new(self.model_name, {{ field.name.stringify }})
        end
      end
    {% end %}
    #
    # --------------------------------------------------------------------------
    Crymon::Globals::OutputData.new(result_bson, !is_error_symptom?)
  end
end
