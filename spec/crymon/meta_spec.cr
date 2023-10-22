require "../spec_helper"

describe Crymon do
  describe "Crymon::Meta" do
    describe ".new" do
      it "create instance of Meta" do
        m = Crymon::Meta.new(
          model_name: "",
          app_name: "",
          unique_app_key: "",
          service_name: "",
          database_name: "",
          collection_name: "",
          fields_count: 0_u32,
          fields_name: Array(String).new,
          field_value_type_map: Hash(String, String).new,
          field_type_map: Hash(String, String).new,
          default_value_map: Hash(String, String).new,
          ignore_fields: Array(String).new,
          choice_str_map: Hash(String, Array(String)).new,
          choice_i64_map: Hash(String, Array(Int64)).new,
          choice_f64_map: Hash(String, Array(Float64)).new,
          model_json: "",
          db_query_docs_limit: = 1000,
          is_add_doc: = true,
          is_up_doc: true,
          is_del_doc: true,
          is_use_addition: false,
          is_use_hooks: false,
          is_use_hash_slug: false
        )
        m.model_name.should eq("")
      end
    end
  end
end
