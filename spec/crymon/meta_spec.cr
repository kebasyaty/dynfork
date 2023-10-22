require "../spec_helper"

describe Crymon do
  describe "Crymon::Meta" do
    describe ".new" do
      it "create instance of Meta" do
        m = Crymon::Meta.new(
          model_name: "ModelName",
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
          db_query_docs_limit: 2000,
          is_add_doc: false,
          is_up_doc: false,
          is_del_doc: false,
          is_use_addition: true,
          is_use_hooks: true,
          is_use_hash_slug: true
        )
        m.model_name.should eq("ModelName")
        m.app_name.should eq("")
        m.unique_app_key.should eq("")
        m.service_name.should eq("")
        m.database_name.should eq("")
        m.collection_name.should eq("")
        m.fields_count.should eq(0_u32)
        m.fields_name.should eq(Array(String).new)
        m.field_value_type_map.should eq(Hash(String, String).new)
        m.field_type_map.should eq(Hash(String, String).new)
        m.default_value_map.should eq(Hash(String, String).new)
        m.ignore_fields.should eq(Array(String).new)
        m.choice_str_map.should eq(Hash(String, Array(String)).new)
        m.choice_i64_map.should eq(Hash(String, Array(Int64)).new)
        m.choice_f64_map.should eq(Hash(String, Array(Float64)).new)
        m.model_json.should eq("")
        m.db_query_docs_limit.should eq(2000_u32)
        m.is_add_doc.should be_false
        m.is_up_doc.should be_false
        m.is_del_doc.should be_false
        m.is_use_addition.should be_true
        m.is_use_hooks.should be_true
        m.is_use_hash_slug.should be_true
      end
    end
  end
end
