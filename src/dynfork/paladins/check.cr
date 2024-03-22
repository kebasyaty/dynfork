require "./check_plus"
require "./groups/*"

# 1.Validation of Model data before saving to the database.
# <br>
# 2.Web form validation. It is recommended to use the _saving_docs?=true_ model parameter.
module DynFork::Paladins::Check
  include DynFork::Paladins::CheckPlus
  include DynFork::Paladins::Groups

  # Validation of Model data.
  def check(
    collection_ptr : Pointer(Mongo::Collection),
    save? : Bool = false
  ) : DynFork::Globals::OutputData
    # Data to save or update to the database.
    result_map : Hash(String, DynFork::Globals::ResultMapType) = Hash(String, DynFork::Globals::ResultMapType).new
    result_map_ptr : Pointer(Hash(String, DynFork::Globals::ResultMapType)) = pointerof(result_map)
    # Does the document exist in the database?
    update? : Bool = !@hash.value?.nil? && !@hash.value.empty?
    # Validation the hash field value.
    if update? && !BSON::ObjectId.validate(@hash.value)
      msg = "Model: `#{@@meta.not_nil![:model_name]}` > " +
            "Field: `hash` => The hash field value is not valid."
      raise DynFork::Errors::Panic.new msg
    end
    if save? && !update?
      id : BSON::ObjectId = BSON::ObjectId.new
      @hash.value = id.to_s
      result_map["_id"] = id
    end
    # Addresses of files to be deleted (if error_symptom? = true).
    cleanup_map : NamedTuple(
      files: Array(String),
      images: Array(String),
    ) = {files: Array(String).new, images: Array(String).new}
    cleanup_map_ptr : Pointer(NamedTuple(
      files: Array(String),
      images: Array(String),
    )) = pointerof(cleanup_map)
    # Is there any incorrect data?
    error_symptom? : Bool = false
    error_symptom_ptr? : Pointer(Bool) = pointerof(error_symptom?)
    # Errors from additional validation of fields.
    error_map : Hash(String, String) = self.add_validation
    # Current error message.
    err_msg : String?

    # Start checking all fields.
    {% for field in @type.instance_vars %}
      # Reset a field errors to exclude duplicates.
      @{{ field }}.errors = Array(String).new
      # Check additional validation.
      unless (err_msg = error_map[{{ field.name.stringify }}]?).nil?
          @{{ field }}.errors << err_msg
          (error_symptom? = true) unless error_symptom?
          err_msg = nil
      end
      #
      unless @{{ field }}.ignored?
        case @{{ field }}.group
        when 1
          # Validation of `text` type fields:
          # <br>
          # _"ColorField" | "EmailField" | "PasswordField" | "PhoneField"
          # | "TextField" | "HashField" | "URLField" | "IPField"_
          self.group_01(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map_ptr,
            collection_ptr
          )
        when 2
          # Validation of `date` type fields:
          # <br>
          # _"DateField" | "DateTimeField"_
          self.group_02(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map_ptr,
            collection_ptr
          )
        when 3
          # Validation of `choice` type fields:
          # <br>
          # _"ChoiceTextField" | "ChoiceI64Field"
          # | "ChoiceF64Field" | "ChoiceTextMultField"
          # | "ChoiceI64MultField" | "ChoiceF64MultField"
          # | "ChoiceTextMultField" | "ChoiceI64MultField"
          # | "ChoiceF64MultField" | "ChoiceTextMultDynField"
          # | "ChoiceI64MultDynField" | "ChoiceF64MultDynField"_
          self.group_03(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map_ptr,
            collection_ptr
          )
        when 4
          # Validation of fields of type FileField.
          self.group_04(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map_ptr,
            cleanup_map_ptr
          )
        when 5
          # Validation of fields of type ImageField.
          self.group_05(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map_ptr,
            cleanup_map_ptr
          )
        when 6
          # Validation of fields of type I64Field.
          self.group_06(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map_ptr,
            collection_ptr
          )
        when 7
          # Validation of fields of type F64Field.
          self.group_07(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map_ptr,
            collection_ptr
          )
        when 8
          # Validation of fields of type BoolField.
          self.group_08(
            pointerof(@{{ field }}),
            save?,
            result_map_ptr
          )
        when 9
          # Create string for SlugField.
          if save?
            self.group_09(
              pointerof(@{{ field }}),
              result_map_ptr
            )
          end
        else
          raise DynFork::Errors::Model::InvalidGroupNumber
            .new(self.model_name, {{ field.name.stringify }})
        end
      end
    {% end %}

    # Actions in case of error.
    if error_symptom?
      # Reset the hash for a new document.
      (@hash.value = nil) if save? && !update?
      # Delete new files.
      cleanup_map[:files].each do |path|
        File.delete(path)
      end
      # Delete new images.
      cleanup_map[:images].each do |path|
        FileUtils.rm_rf(path)
      end
    end
    #
    # --------------------------------------------------------------------------
    DynFork::Globals::OutputData.new(
      data: result_map,
      valid: !error_symptom?,
      update: update?
    )
  end
end
