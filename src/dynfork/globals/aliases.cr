# Global data types.
module DynFork::Globals::Aliases
  # All field types.
  alias FieldTypes = DynFork::Fields::URLField | DynFork::Fields::TextField |
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

  # Field value types.
  alias ValueTypes = String | Int64 | Float64 | DynFork::Globals::ImageData |
                     DynFork::Globals::FileData | Array(String) | Array(Int64) |
                     Array(Float64) | Bool | Nil

  # For struct DynFork::Globals::OutputData.
  alias ResultMapType = String | Int64 | Float64 | DynFork::Globals::ImageData |
                        DynFork::Globals::FileData | Array(String) | Array(Int64) |
                        Array(Float64) | Bool | Nil | Time | BSON::ObjectId

  # Data types to select in dynamic fields.
  alias DataDynamicTypes = Array(String | Int64 | Float64)

  # A type for caching Metadata of Model.
  alias CacheMetaDataType = NamedTuple(
    model_name: String,
    service_name: String,
    collection_name: String,
    db_query_docs_limit: UInt32,
    field_count: Int32,
    field_name_and_type_list: Hash(String, String),
    default_value_list: Hash(String, DynFork::Globals::ValueTypes),
    saving_docs?: Bool,
    updating_docs?: Bool,
    deleting_docs?: Bool,
    ignore_fields: Array(String),
    field_attrs: Hash(String, NamedTuple(id: String, name: String)),
    data_dynamic_fields: Hash(String, String),
    time_object_list: Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)),
    fixture_name: String?,
  )

  # A type for caching regular expressions.
  alias CacheRegexType = NamedTuple(
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
  )
end
