module Crymon
  # Metadata for Model.
  struct Meta
    getter model_name : String = ""
    getter app_name : String = ""
    getter unique_app_key : String = ""
    getter service_name : String = ""
    getter database_name : String = ""
    getter collection_name : String = ""
    getter db_query_docs_limit : UInt32 = 1000
    getter fields_count : UInt32 = 0
    getter fields_name : Array(String) = Array(String).new
    getter is_add_doc : Bool = true
    getter is_up_doc : Bool = true
    getter is_del_doc : Bool = true
    getter is_use_addition : Bool = false
    getter is_use_hooks : Bool = false
    getter is_use_hash_slug : Bool = false
    # Format: <field_name, field_value_type>
    getter field_value_type_map : Hash(String, String) = Hash(String, String).new
    # Format: <field_name, fields_type>
    getter field_type_map : Hash(String, String) = Hash(String, String).new
    # Format: <field_name, default_value>
    getter default_value_map : Hash(String, String) = Hash(String, String).new
    # List of field names that will not be saved to the database.
    getter ignore_fields : Array(String) = Array(String).new
    # Choice maps for fields type `choice`.
    # Format: HashMap<field_name, choices>
    getter choice_str_map : Hash(String, Array(String)) = Hash(String, Array(String)).new
    getter choice_i64_map : Hash(String, Array(Int64)) = Hash(String, Array(Int64)).new
    getter choice_f64_map : Hash(String, Array(Float64)) = Hash(String, Array(Float64)).new
    #
    getter model_json : String = ""
  end

  def initialize(
    @model_name : String,
    @app_name : String,
    @unique_app_key : String,
    @service_name : String,
    @database_name : String,
    @collection_name : String,
    @fields_count : UInt32,
    @fields_name : Array(String),
    @field_value_type_map : Hash(String, String),
    @field_type_map : Hash(String, String),
    @default_value_map : Hash(String, String),
    @ignore_fields : Array(String),
    @choice_str_map : Hash(String, Array(String)),
    @choice_i64_map : Hash(String, Array(Int64)),
    @choice_f64_map : Hash(String, Array(Float64)),
    @model_json : String,
    @db_query_docs_limit : UInt32 = 1000,
    @is_add_doc : Bool = true,
    @is_up_doc : Bool = true,
    @is_del_doc : Bool = true,
    @is_use_addition : Bool = false,
    @is_use_hooks : Bool = false,
    @is_use_hash_slug : Bool = false
  ); end
end
