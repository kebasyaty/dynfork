module Crymon
  struct Meta
    getter model_name : String
    getter app_name : String
    getter unique_app_key : String
    getter service_name : String
    getter database_name : String
    getter collection_name : String
    getter db_query_docs_limit : Uint32
    getter fields_count : Uint32
    getter fields_name : Array(String)
    getter is_add_doc : Bool
    getter is_up_doc : Bool
    getter is_del_doc : Bool
  end

  def initialize(
    @model_name : String = "",
    @app_name : String = "",
    @unique_app_key : String = "",
    @service_name : String = "",
    @database_name : String = "",
    @collection_name : String = "",
    @db_query_docs_limit : UInt32 = 1000,
    @fields_count : UInt32 = 0,
    @fields_name : Array(String) = Array(String).new,
    @is_add_doc : Bool = true,
    @is_up_doc : Bool = true,
    @is_del_doc : Bool = true
  ); end
end
