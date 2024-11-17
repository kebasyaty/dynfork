require "../../spec_helper"

describe DynFork::Migration::ModelState do
  describe ".new" do
    it "=> create instance", tags: "migration" do
      ms = DynFork::Migration::ModelState.new(
        collection_name: "ServiceName_ModelName",
        field_name_and_type_list: {"field_name" => "TextField", "field_name_2" => "EmailField"},
        data_dynamic_fields: Hash(String, String).new,
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.data_dynamic_fields.should eq(Hash(String, String).new)
      ms.model_exists?.should be_false
    end
  end
end

describe DynFork::Migration::Monitor do
  describe "#migrat" do
    it "=> run migration process", tags: "migration" do
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_key = "23x9QdB2zb7nsG6H"
      database_name = "test_#{unique_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      mongo_client = Mongo::Client.new(mongo_uri)
      Spec::Support.delete_test_db(mongo_client[database_name])
      mongo_client.close

      # Run migration.
      m = DynFork::Migration::Monitor.new(
        database_name: database_name,
      )
      m.migrat.should be_nil

      # Checking for data updates for dynamic fields.
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_text_dyn"].should eq("[]")
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_text_mult_dyn"].should eq("[]")
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_i64_dyn"].should eq("[]")
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_i64_mult_dyn"].should eq("[]")
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_f64_dyn"].should eq("[]")
      Spec::Data::DefaultNoNil.meta[:data_dynamic_fields]["choice_f64_mult_dyn"].should eq("[]")
      #
      FileUtils.rm_rf("public/media/uploads/files")
      FileUtils.rm_rf("public/media/uploads/images")
      #
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.mongo_database)
      #
      DynFork::Globals.mongo_client.close
    end
  end
end
