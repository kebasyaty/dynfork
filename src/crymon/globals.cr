module Crymon
  module Globals
    # Global storage for metadata caching.
    class_property store_metadata : Hash(String, Crymon::Globals::StoreMetaDataType) = Hash(String, Crymon::Globals::StoreMetaDataType).new
    # Global storage for Mongodb client caching.
    class_property store_mongo_client : Mongo::Client?
    # Global storage for super collection name caching.
    # <br>
    # <br>
    # Super collection is used for:
    # - _Store technical data for Models migration into a database._
    # - _Store dynamic field data for simulate relationship Many-to-One and Many-to-Manyю._
    class_property store_super_collection_name : String = "SUPER_COLLECTION"
    # Global storage for regex caching.
    class_property store_regex : StoreRegexType = NamedTuple.new(
      model_name: Regex.new("^[A-Z][a-zA-Z0-9]{0,24}$"),
      app_name: Regex.new("^[a-zA-Z][-_a-zA-Z0-9]{0,43}$"),
      unique_app_key: Regex.new("^[a-zA-Z0-9]{16}$"),
      service_name: Regex.new("^[A-Z][a-zA-Z0-9]{0,24}$"),
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
    alias ValueTypes = String | UInt32 | Int64 | Float64 | Crymon::Fields::ImageData |
                       Crymon::Fields::FileData | Array(UInt32) | Array(String) | Array(Int64) |
                       Array(Float64) | Bool | Nil

    # Data types to select in dynamic fields.
    alias DataDynamicTypes = Array(String) | Array(UInt32) | Array(Int64) | Array(Float64) | Nil

    # A type for caching Metadata of Model.
    alias StoreMetaDataType = NamedTuple(
      app_name: String,
      model_name: String,
      unique_app_key: String,
      service_name: String,
      database_name: String,
      collection_name: String,
      db_query_docs_limit: UInt32,
      field_count: Int32,
      field_name_list: Array(String),
      field_type_list: Array(String),
      field_name_and_type_list: Hash(String, String),
      default_value_list: Hash(String, Crymon::Globals::ValueTypes),
      is_add_doc: Bool,
      is_up_doc: Bool,
      is_del_doc: Bool,
      is_use_addition: Bool,
      is_use_hooks: Bool,
      is_use_hash_slug: Bool,
      ignore_fields: Array(String),
      field_attrs: Hash(String, NamedTuple(id: String, name: String)),
      data_dynamic_fields: Hash(String, Crymon::Globals::DataDynamicTypes),
    )

    # A type for caching regular expressions.
    alias StoreRegexType = NamedTuple(
      model_name: Regex,
      app_name: Regex,
      unique_app_key: Regex,
      service_name: Regex,
    )
  end
end
