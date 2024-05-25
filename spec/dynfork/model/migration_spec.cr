require "../../spec_helper"

describe DynFork::Migration::ModelState do
  describe ".new" do
    it "=> create instance without model_exists", tags: "migration" do
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

    it "=> create instance with model_exists", tags: "migration" do
      ms = DynFork::Migration::ModelState.new(
        collection_name: "ServiceName_ModelName",
        field_name_and_type_list: {"field_name" => "TextField", "field_name_2" => "EmailField"},
        data_dynamic_fields: Hash(String, String).new,
        model_exists: true
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.data_dynamic_fields.should eq(Hash(String, String).new)
      ms.model_exists?.should be_true
    end
  end
end

describe DynFork::Migration::Monitor do
  describe ".new" do
    it "=> create instance without database name", tags: "migration" do
      DynFork::Migration::Monitor.new(
        app_name: "AppName",
        unique_app_key: "0w7n5731X13s1641",
        mongo_client: Mongo::Client.new("mongodb://localhost:27017")
      )
      #
      DynFork::Globals.app_name.should eq("AppName")
      DynFork::Globals.unique_app_key.should eq("0w7n5731X13s1641")
      DynFork::Globals.database_name.should eq("AppName_0w7n5731X13s1641")
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

    it "=> create instance with database name", tags: "migration" do
      DynFork::Migration::Monitor.new(
        app_name: "AppName",
        unique_app_key: "0585I0S5huR5r08q",
        database_name: "DatabaseName360",
        mongo_client: Mongo::Client.new("mongodb://localhost:27017")
      )
      #
      DynFork::Globals.app_name.should eq("AppName")
      DynFork::Globals.unique_app_key.should eq("0585I0S5huR5r08q")
      DynFork::Globals.database_name.should eq("DatabaseName360")
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

    it "=> create instance and testing model list", tags: "migration" do
      # Run migration.
      DynFork::Migration::Monitor.new(
        app_name: "AppName",
        unique_app_key: "0w7n5731X13s1641",
        mongo_client: Mongo::Client.new("mongodb://localhost:27017")
      )
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

  describe "#migrat" do
    it "=> run migration process", tags: "migration" do
      # Init data for test.
      # unique_app_key = Spec::Support.generate_unique_app_key
      # database_name = "test_#{unique_app_key}"
      # mongo_uri = "mongodb://localhost:27017"

      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "23x9QdB2zb7nsG6H"
      database_name = "test_#{unique_app_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      Spec::Support.delete_test_db(
        Mongo::Client.new(mongo_uri)[database_name])
      #
      DynFork::Globals.mongo_client.close

      # Run migration.
      m = DynFork::Migration::Monitor.new(
        app_name: "AppName",
        unique_app_key: unique_app_key,
        database_name: database_name,
        mongo_client: Mongo::Client.new(mongo_uri)
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
