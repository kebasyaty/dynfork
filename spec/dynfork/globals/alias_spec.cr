require "../../spec_helper"

describe DynFork::Globals do
  describe "alias" do
    it "=> FieldTypes - type checking", tags: "global_alias" do
      DynFork::Globals::FieldTypes.should eq(
        DynFork::Fields::URLField | DynFork::Fields::TextField |
        DynFork::Fields::SlugField | DynFork::Fields::PhoneField |
        DynFork::Fields::PasswordField | DynFork::Fields::I64Field |
        DynFork::Fields::F64Field | DynFork::Fields::IPField |
        DynFork::Fields::ImageField | DynFork::Fields::HashField |
        DynFork::Fields::FileField | DynFork::Fields::EmailField |
        DynFork::Fields::DateTimeField | DynFork::Fields::DateField |
        DynFork::Fields::ColorField | DynFork::Fields::ChoiceTextField |
        DynFork::Fields::ChoiceTextMultField | DynFork::Fields::ChoiceTextDynField |
        DynFork::Fields::ChoiceTextMultDynField | DynFork::Fields::ChoiceI64Field |
        DynFork::Fields::ChoiceI64MultField | DynFork::Fields::ChoiceI64DynField |
        DynFork::Fields::ChoiceI64MultDynField | DynFork::Fields::ChoiceF64Field |
        DynFork::Fields::ChoiceF64MultField | DynFork::Fields::ChoiceF64DynField |
        DynFork::Fields::ChoiceF64MultDynField | DynFork::Fields::BoolField
      )
    end

    it "=> ValueTypes - type checking", tags: "global_alias" do
      DynFork::Globals::ValueTypes.should eq(
        String | Int64 | Float64 | DynFork::Globals::ImageData |
        DynFork::Globals::FileData | Array(String) | Array(Int64) |
        Array(Float64) | Bool | Nil
      )
    end

    it "=> DataDynamicTypes - type checking", tags: "global_alias" do
      DynFork::Globals::DataDynamicTypes.should eq(
        Array(String | Int64 | Float64)
      )
    end

    it "=> CacheMetaDataType - type checking", tags: "global_alias" do
      DynFork::Globals::CacheMetaDataType.should eq(
        NamedTuple(
          model_name: String,
          service_name: String,
          collection_name: String,
          db_query_docs_limit: Int32,
          field_count: Int32,
          field_name_and_type_list: Hash(String, String),
          field_name_params_list: Hash(String, NamedTuple(type: String, group: UInt8)),
          default_value_list: Hash(String, DynFork::Globals::ValueTypes),
          ignored_model?: Bool,
          create_doc?: Bool,
          update_doc?: Bool,
          delete_doc?: Bool,
          ignored_fields: Array(String),
          field_attrs: Hash(String, NamedTuple(id: String, name: String)),
          data_dynamic_fields: Hash(String, String),
          time_object_list: Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)),
          fixture_name: String?,
        )
      )
    end

    it "=> CacheRegexType - type checking", tags: "global_alias" do
      DynFork::Globals::CacheRegexType.should eq(
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
          color_code: Regex,
          password: Regex,
        )
      )
    end
  end
end
