require "./types"

# Global storage for data cache.
module Crymon::Globals
  include Crymon::Globals::Types

  # Global storage for metadata caching.
  class_getter cache_metadata = Hash(String, Crymon::Globals::CacheMetaDataType).new
  # Global storage for Mongodb client caching.
  class_property cache_mongo_client : Mongo::Client = Mongo::Client.new
  # Global storage for super collection name caching.
  # <br>
  # <br>
  # Super collection is used for:
  # - _Store technical data for Models migration into a database._
  # - _Store dynamic field data for simulate relationship Many-to-One and Many-to-Manyю._
  class_getter cache_super_collection_name = "SUPER_COLLECTION"
  # Global Crymon settings.
  class_property cache_app_name : String = ""
  class_property cache_unique_app_key : String = ""
  class_property cache_database_name : String = ""
  # Global storage for regex caching.
  class_getter cache_regex : CacheRegexType = NamedTuple.new(
    model_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
    app_name: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/,
    unique_app_key: /^[a-zA-Z0-9]{16}$/,
    service_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
    get_type_marker: /(Text|U32|I64|F64)/,
    date_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})$/,
    date_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})$/,
    datetime_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})/,
    datetime_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})/,
  )

  # All field types.
  alias FieldTypes = Crymon::Fields::URLField | Crymon::Fields::TextField |
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

  # Field value types.
  alias ValueTypes = String | UInt32 | Int64 | Float64 | Crymon::Globals::ImageData |
                     Crymon::Globals::FileData | Array(UInt32) | Array(String) | Array(Int64) |
                     Array(Float64) | Bool | Nil

  # Data types to select in dynamic fields.
  alias DataDynamicTypes = Array(String | UInt32 | Int64 | Float64)

  # A type for caching Metadata of Model.
  alias CacheMetaDataType = NamedTuple(
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
  )
end
