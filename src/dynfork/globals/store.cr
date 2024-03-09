require "./aliases"
require "./types"

# Global storage for data cache.
module DynFork::Globals
  include DynFork::Globals::Aliases
  include DynFork::Globals::Types

  # Mongo client caching.
  class_property! cache_mongo_client : Mongo::Client
  # Mongo database caching.
  class_property! cache_mongo_database : Mongo::Database
  # Super collection name caching.
  # <br>
  # <br>
  # Super collection is used for:
  # - _Store technical data for Models migration into a database._
  # - _Store dynamic field data for simulate relationship Many-to-One and Many-to-Manyю._
  class_getter cache_super_collection_name = "SUPER_COLLECTION"
  # Global DynFork settings.
  class_property cache_app_name : String = ""
  class_property cache_unique_app_key : String = ""
  class_property cache_database_name : String = ""
  # Regex caching.
  class_getter cache_regex : CacheRegexType = NamedTuple.new(
    model_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
    app_name: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/,
    unique_app_key: /^[a-zA-Z0-9]{16}$/,
    service_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
    get_type_marker: /(Text|U32|I64|F64)/,
    date_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})$/,
    date_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})$/,
    datetime_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2}:[0-9]{2})/,
    datetime_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2}:[0-9]{2})/,
    color_code: /^(?:#|0x)(?:[a-f0-9]{3}|[a-f0-9]{6}|[a-f0-9]{8})\b|(?:rgb|hsl)a?\([^\)]*\)$/i,
  )
end
