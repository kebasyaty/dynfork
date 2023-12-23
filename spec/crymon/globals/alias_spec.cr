require "../../spec_helper"

describe Crymon::Globals do
  describe "alias" do
    it "=> FieldTypes - type checking", tags: "global_alias" do
      Crymon::Globals::FieldTypes.should eq(
        Crymon::Fields::URLField | Crymon::Fields::TextField |
        Crymon::Fields::SlugField | Crymon::Fields::PhoneField |
        Crymon::Fields::PasswordField | Crymon::Fields::U32Field |
        Crymon::Fields::I64Field | Crymon::Fields::F64Field |
        Crymon::Fields::IPField | Crymon::Fields::ImageField |
        Crymon::Fields::HashField | Crymon::Fields::FileField |
        Crymon::Fields::EmailField | Crymon::Fields::DateTimeField |
        Crymon::Fields::DateField | Crymon::Fields::ColorField |
        Crymon::Fields::ChoiceU32Field | Crymon::Fields::ChoiceU32MultField |
        Crymon::Fields::ChoiceU32DynField | Crymon::Fields::ChoiceU32MultDynField |
        Crymon::Fields::ChoiceTextField | Crymon::Fields::ChoiceTextMultField |
        Crymon::Fields::ChoiceTextDynField | Crymon::Fields::ChoiceTextMultDynField |
        Crymon::Fields::ChoiceI64Field | Crymon::Fields::ChoiceI64MultField |
        Crymon::Fields::ChoiceI64DynField | Crymon::Fields::ChoiceI64MultDynField |
        Crymon::Fields::ChoiceF64Field | Crymon::Fields::ChoiceF64MultField |
        Crymon::Fields::ChoiceF64DynField | Crymon::Fields::ChoiceF64MultDynField |
        Crymon::Fields::BoolField
      )
    end

    it "=> ValueTypes - type checking", tags: "global_alias" do
      Crymon::Globals::ValueTypes.should eq(
        String | UInt32 | Int64 | Float64 | Crymon::Fields::ImageData |
        Crymon::Fields::FileData | Array(UInt32) | Array(String) | Array(Int64) |
        Array(Float64) | Bool | Nil
      )
    end

    it "=> DataDynamicTypes - type checking", tags: "global_alias" do
      Crymon::Globals::DataDynamicTypes.should eq(
        Array(String | UInt32 | Int64 | Float64)
      )
    end

    it "=> CacheMetaDataType - type checking", tags: "global_alias" do
      Crymon::Globals::CacheMetaDataType.should eq(
        NamedTuple(
          model_name: String,
          service_name: String,
          collection_name: String,
          db_query_docs_limit: UInt32,
          field_count: Int32,
          field_name_and_type_list: Hash(String, String),
          default_value_list: Hash(String, Crymon::Globals::ValueTypes),
          is_saving_docs: Bool,
          is_updating_docs: Bool,
          is_deleting_docs: Bool,
          is_use_hash_slug: Bool,
          ignore_fields: Array(String),
          field_attrs: Hash(String, NamedTuple(id: String, name: String)),
          data_dynamic_fields: Hash(String, String),
          time_object_list: Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)),
        )
      )
    end

    it "=> CacheRegexType - type checking", tags: "global_alias" do
      Crymon::Globals::CacheRegexType.should eq(
        NamedTuple(
          model_name: Regex,
          app_name: Regex,
          unique_app_key: Regex,
          service_name: Regex,
          get_type_marker: Regex,
          date_parse: Regex,
          date_parse_reverse: Regex,
          datetime_parse: Regex,
          datetime_parse_reverse: Regex,
        )
      )
    end
  end
end
