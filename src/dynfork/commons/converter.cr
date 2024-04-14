# Methods for obtaining clean data from documents.
module DynFork::Commons::Converter
  extend self

  # Get clean data from a document, as a Hash object.
  def document_to_hash(
    doc_ptr : Pointer(BSON),
    field_name_type_group_list_ptr : Pointer(Hash(String, NamedTuple(type: String, group: UInt8)))
  ) : Hash(String, DynFork::Globals::ValueTypes)
    #
    doc_hash = doc_ptr.value.not_nil!.to_h
    result = Hash(String, DynFork::Globals::ValueTypes).new
    result["hash"] = doc_hash["_id"].as(BSON::ObjectId).to_s
    field_type : String = ""
    #
    field_name_type_group_list_ptr.value.each do |field_name, field_info|
      if !(value = doc_hash[field_name]).nil?
        field_type = field_info.not_nil![:type]
        case field_info.not_nil![:group]
        when 1
          # ColorField | EmailField | PasswordField | PhoneField
          # | TextField | HashField | URLField | IPField
          if field_type != "PasswordField"
            result[field_name] = value.as(String)
          else
            result[field_name] = nil
          end
        when 2
          # DateField | DateTimeField
          if field_type.includes?("Time")
            result[field_name] = value.as(Time).to_s("%FT%H:%M:%S")
          else
            result[field_name] = value.as(Time).to_s("%F")
          end
        when 3
          # ChoiceTextField | ChoiceI64Field
          # | ChoiceF64Field | ChoiceTextMultField
          # | ChoiceI64MultField | ChoiceF64MultField
          # | ChoiceTextMultField | ChoiceI64MultField
          # | ChoiceF64MultField | ChoiceTextMultDynField
          # | ChoiceI64MultDynField | ChoiceF64MultDynField
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
        when 4
          # FileField
          bson = BSON.new
          value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
          result[field_name] = DynFork::Globals::FileData.from_bson(bson)
        when 5
          # ImageField
          bson = BSON.new
          value.as(Hash(String, BSON::RecursiveValue)).each { |key, val| bson[key] = val }
          result[field_name] = DynFork::Globals::ImageData.from_bson(bson)
        when 6
          # I64Field
          result[field_name] = value.as(Int64)
        when 7
          # F64Field
          result[field_name] = value.as(Float64)
        when 8
          # BoolField
          result[field_name] = value.as(Bool)
        when 9
          # SlugField
          result[field_name] = value.as(String)
        else
          raise DynFork::Errors::Model::InvalidGroupNumber
            .new(@@full_model_name, field_name)
        end
      else
        result[field_name] = nil
      end
    end
    #
    result
  end
end
