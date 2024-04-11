# ???
module DynFork::Commons::Converter
  extend self

  # WARNING: `PasswordField` is excluded from the list.
  TEXT_FIELD_TYPES = [
    "ColorField",
    "EmailField",
    "PhoneField",
    "TextField",
    "HashField",
    "URLField",
    "IPField",
  ]

  # Get clean data from a document, in the form of a Hash object.
  def document_to_hash(doc_ptr : Pointer(BSON)) : Hash(String, DynFork::Globals::ValueTypes)
    doc_hash = doc_ptr.value.not_nil!.to_h
    result = Hash(String, DynFork::Globals::ValueTypes).new
    result["hash"] = doc_hash["_id"].as(BSON::ObjectId).to_s
    #
    @@meta.not_nil![:field_name_and_type_list].each do |field_name, field_type|
      if !(value = doc_hash[field_name]).nil?
        if TEXT_FIELD_TYPES.includes?(field_type)
          result[field_name] = value.as(String)
        elsif field_type.includes?("Date")
          if field_type.includes?("Time")
            result[field_name] = value.as(Time).to_s("%FT%H:%M:%S")
          else
            result[field_name] = value.as(Time).to_s("%F")
          end
        elsif field_type.includes?("Choice")
          # ChoiceTextField | ChoiceI64Field
          # | ChoiceF64Field | ChoiceTextMultField
          # | ChoiceI64MultField | ChoiceF64MultField
          # | ChoiceTextMultField | ChoiceI64MultField
          # | ChoiceF64MultField | ChoiceTextMultDynField
          # | ChoiceI64MultDynField | ChoiceF64MultDynField
          if field_type.includes?("Text")
            if field_type.includes?("Mult")
              result[field_name] = value.as(
                Array(BSON::RecursiveValue)).map { |item| item.as(String) }
            else
              result[field_name] = value.as(String)
            end
          elsif field_type.includes?("I64")
            if field_type.includes?("Mult")
              result[field_name] = value.as(
                Array(BSON::RecursiveValue)).map { |item| item.as(Int64) }
            else
              result[field_name] = value.as(Int64)
            end
          elsif field_type.includes?("F64")
            if field_type.includes?("Mult")
              result[field_name] = value.as(
                Array(BSON::RecursiveValue)).map { |item| item.as(Float64) }
            else
              result[field_name] = value.as(Float64)
            end
          end
        elsif field_type == "FileField"
          bson = BSON.new
          value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
          result[field_name] = DynFork::Globals::FileData.from_bson(bson)
        elsif field_type == "ImageField"
          bson = BSON.new
          value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
          result[field_name] = DynFork::Globals::ImageData.from_bson(bson)
        elsif field_type == "I64Field"
          result[field_name] = value.as(Int64)
        elsif field_type == "F64Field"
          result[field_name] = value.as(Float64)
        elsif field_type == "BoolField"
          result[field_name] = value.as(Bool)
        elsif field_type == "SlugField"
          result[field_name] = value.as(String)
        elsif field_type == "PasswordField"
          result[field_name] = nil
        else
          raise DynFork::Errors::Model::InvalidFieldType
            .new(@@full_model_name, "document_to_hash", field_name, field_type)
        end
      else
        result[field_name] = nil
      end
    end
    #
    result
  end
end
