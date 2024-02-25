# Global data types.
module Crymon::Globals::Aliases
  # All field types.
  alias FieldTypes = Crymon::Fields::URLField | Crymon::Fields::TextField |
                     Crymon::Fields::SlugField | Crymon::Fields::PhoneField |
                     Crymon::Fields::PasswordField | Crymon::Fields::I64Field |
                     Crymon::Fields::F64Field | Crymon::Fields::IPField |
                     Crymon::Fields::ImageField | Crymon::Fields::HashField |
                     Crymon::Fields::FileField | Crymon::Fields::EmailField |
                     Crymon::Fields::DateTimeField | Crymon::Fields::DateField |
                     Crymon::Fields::ColorField | Crymon::Fields::ChoiceTextField |
                     Crymon::Fields::ChoiceTextMultField | Crymon::Fields::ChoiceTextDynField |
                     Crymon::Fields::ChoiceTextMultDynField | Crymon::Fields::ChoiceI64Field |
                     Crymon::Fields::ChoiceI64MultField | Crymon::Fields::ChoiceI64DynField |
                     Crymon::Fields::ChoiceI64MultDynField | Crymon::Fields::ChoiceF64Field |
                     Crymon::Fields::ChoiceF64MultField | Crymon::Fields::ChoiceF64DynField |
                     Crymon::Fields::ChoiceF64MultDynField | Crymon::Fields::BoolField

  # Field value types.
  alias ValueTypes = String | Int64 | Float64 | Crymon::Globals::ImageData |
                     Crymon::Globals::FileData | Array(String) | Array(Int64) |
                     Array(Float64) | Bool | Nil

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
    default_value_list: Hash(String, Crymon::Globals::ValueTypes),
    saving_docs?: Bool,
    updating_docs?: Bool,
    deleting_docs?: Bool,
    use_hash_slug?: Bool,
    ignore_fields: Array(String),
    field_attrs: Hash(String, NamedTuple(id: String, name: String)),
    data_dynamic_fields: Hash(String, String),
    time_object_list: Hash(String, NamedTuple(default: Time?, max: Time?, min: Time?)),
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
