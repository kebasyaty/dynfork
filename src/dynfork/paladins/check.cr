require "./groups/*"

# 1.Validation of Model data before saving to the database.
# <br>
# 2.Web form validation. It is recommended to use the _saving_docs?=true_ model parameter.
module DynFork::QPaladins::Check
  include DynFork::QPaladins::Groups

  # Validation of Model data.
  # NOTE: This method is used within the `DynFork::QPaladins::Tools#valid?` and `DynFork::QPaladins::Save#save` methods.
  def check(
    collection_ptr : Pointer(Mongo::Collection),
    save? : Bool = false
  ) : DynFork::Globals::OutputData
    # Data to save or update to the database.
    result_map : Hash(String, DynFork::Globals::ResultMapType) = Hash(String, DynFork::Globals::ResultMapType).new
    # Get the document ID.
    id : BSON::ObjectId? = self.object_id
    id_ptr : Pointer(BSON::ObjectId?) = pointerof(id)
    # Does the document exist in the database?
    update? : Bool = !id.nil?
    # Create an identifier for a new document.
    if !update?
      100.times do |idx|
        id = BSON::ObjectId.new
        if collection_ptr.value.count_documents({_id: id}) == 0
          break
        elsif idx == 99
          raise DynFork::Errors::Model::FailedGenerateUniqueID.new(@@full_model_name)
        end
      end
    end
    if save?
      @hash.value = id.to_s if !update?
      result_map["_id"] = id
    end
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
        when 1_u8
          # Validation of `text` type fields:
          # <br>
          # ColorField | EmailField | PasswordField | PhoneField
          # | TextField | HashField | URLField | IPField
          self.group_01(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map,
            collection_ptr,
            id_ptr,
          )
        when 2_u8
          # Validation of `date` type fields:
          # <br>
          # DateField | DateTimeField
          self.group_02(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map,
            collection_ptr,
          )
        when 3_u8
          # Validation of `choice` type fields:
          # <br>
          # ChoiceTextField | ChoiceTextMultField
          # | ChoiceTextDynField | ChoiceTextMultDynField
          # | ChoiceI64Field | ChoiceI64MultField
          # | ChoiceI64DynField | ChoiceI64MultDynField
          # | ChoiceF64Field | ChoiceF64MultField
          # | ChoiceF64DynField | ChoiceF64MultDynField
          self.group_03(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map,
            collection_ptr,
          )
        when 4_u8
          # Validation of fields of type FileField.
          self.group_04(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map,
          )
        when 5_u8
          # Validation of fields of type ImageField.
          self.group_05(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            update?,
            save?,
            result_map,
          )
        when 6_u8
          # Validation of fields of type I64Field.
          self.group_06(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map,
            collection_ptr,
            id_ptr,
          )
        when 7_u8
          # Validation of fields of type F64Field.
          self.group_07(
            pointerof(@{{ field }}),
            error_symptom_ptr?,
            save?,
            result_map,
            collection_ptr,
            id_ptr,
          )
        when 8_u8
          # Validation of fields of type BoolField.
          self.group_08(
            pointerof(@{{ field }}),
            save?,
            result_map,
          )
        when 9_u8
          # Create string for SlugField.
          if save?
            self.group_09(
              pointerof(@{{ field }}),
              result_map,
            )
          end
        else
          raise DynFork::Errors::Model::InvalidGroupNumber
            .new(@@full_model_name, {{ field.name.stringify }})
        end
      end
    {% end %}

    # Actions in case of error.
    if save? && error_symptom?
      # Reset the hash for a new document.
      @hash.value = nil if !update?
      # Delete orphaned files.
      file_path : String?
      img_dir_path : String?
      db_file_val = nil
      curr_doc_hash = update? ? collection_ptr.value.find_one({_id: id}).not_nil!.to_h : nil
      {% for field in @type.instance_vars %}
        if !@{{ field }}.ignored? && !@{{ field }}.value.nil?
          if @{{ field }}.group == 4_u8 # FileField
            if update?
              # When updating the document.
              file_path = @{{ field }}.extract_file_path?
              if !(db_file_val = curr_doc_hash.not_nil![@{{ field }}.name]).nil?
                if file_path.not_nil! == db_file_val.not_nil!.as(DynFork::Globals::FileData).path
                  file_path = nil
                end
              end
              File.delete(file_path.not_nil!); file_path = nil unless file_path.nil?
            else
              # When creating a document.
              File.delete(@{{ field }}.extract_file_path?.not_nil!)
            end
          elsif @{{ field }}.group == 5_u8 # ImageField
            if update?
              # When updating the document.
              img_dir_path = @{{ field }}.extract_images_dir_path?
              if !(db_file_val = curr_doc_hash.not_nil![@{{ field }}.name]).nil?
                if img_dir_path.not_nil! == db_file_val.not_nil!.as(DynFork::Globals::ImageData).images_dir_path.not_nil!
                  img_dir_path = nil
                end
              end
              FileUtils.rm_rf(img_dir_path.not_nil!); img_dir_path = nil unless img_dir_path.nil?
            else
              # When creating a document.
              FileUtils.rm_rf(@{{ field }}.extract_images_dir_path?.not_nil!)
            end
          end
        end
      {% end %}
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
