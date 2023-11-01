module Crymon
  module Globals
    # Global storage for metadata caching.
    # NOTE: "meta" - metadata for Model.
    # NOTE: "attrs" - attributes value: id and name.
    # NOTE: "dyns" - data for dynamic fields.
    class_property store : Hash(String, Crymon::Globals::MetaData) = Hash(String, Crymon::Globals::MetaData).new

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

    # Metadata type for Model.
    alias MetaData = NamedTuple(
      "app_name": String,
      "model_name": String,
      "unique_app_key": String,
      "service_name": String,
      "database_name": String,
      "collection_name": String,
      "db_query_docs_limit": UInt32,
      "field_count": Int32,
      "field_name_list": Array(String),
      "field_type_list": Array(String),
      "field_name_and_type_list": Hash(String, String),
      "default_value_list": Hash(String, Crymon::Globals::ValueTypes),
      "is_add_doc": Bool,
      "is_up_doc": Bool,
      "is_del_doc": Bool,
      "is_use_addition": Bool,
      "is_use_hooks": Bool,
      "is_use_hash_slug": Bool,
      "ignore_fields": Array(String),
    )
  end
end
