require "../../spec_helper"

describe DynFork::Migration::ModelState do
  describe ".new" do
    it "=> create instance without model_exists", tags: "migration" do
      ms = DynFork::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"}
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.model_exists?.should be_false
    end

    it "=> create instance with model_exists", tags: "migration" do
      ms = DynFork::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"},
        "model_exists": true
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.model_exists?.should be_true
    end
  end
end

describe DynFork::Migration::Monitor do
  describe ".new" do
    it "=> create instance without database name", tags: "migration" do
      m = DynFork::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Spec::Data::FilledModel,
          Spec::Data::AuxiliaryModel,
        }
      )
      #
      DynFork::Globals.cache_app_name.should eq("AppName")
      DynFork::Globals.cache_unique_app_key.should eq("0w7n5731X13s1641")
      DynFork::Globals.cache_database_name.should eq("AppName_0w7n5731X13s1641")
      #
      m.model_list.should eq({Spec::Data::FilledModel, Spec::Data::AuxiliaryModel})
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
      #
      DynFork::Globals.cache_mongo_client.close
    end

    it "=> create instance with database name", tags: "migration" do
      m = DynFork::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0585I0S5huR5r08q",
        "database_name": "DatabaseName360",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Spec::Data::FilledModel,
          Spec::Data::AuxiliaryModel,
        }
      )
      #
      DynFork::Globals.cache_app_name.should eq("AppName")
      DynFork::Globals.cache_unique_app_key.should eq("0585I0S5huR5r08q")
      DynFork::Globals.cache_database_name.should eq("DatabaseName360")
      #
      m.model_list.should eq({Spec::Data::FilledModel, Spec::Data::AuxiliaryModel})
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
      #
      DynFork::Globals.cache_mongo_client.close
    end

    it "=> create instance and testing model list", tags: "migration" do
      # Run migration.
      m = DynFork::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Spec::Data::FilledModel,
          Spec::Data::AuxiliaryModel,
        }
      )
      #
      m.model_list.should eq({Spec::Data::FilledModel, Spec::Data::AuxiliaryModel})
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
      #
      DynFork::Globals.cache_mongo_client.close
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
      DynFork::Globals.cache_mongo_client.close

      # Run migration.
      m = DynFork::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": unique_app_key,
        "database_name": database_name,
        "mongo_uri": mongo_uri,
        "model_list": {
          Spec::Data::FilledModel,
          Spec::Data::AuxiliaryModel,
        }
      )
      m.migrat.should be_nil

      # Checking for data updates for dynamic fields.
      field_name = "field_name"
      data = "[]"
      Spec::Data::FilledModel.meta[:data_dynamic_fields][field_name] = data
      Spec::Data::FilledModel.meta[:data_dynamic_fields][field_name].should eq(data)

      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
      #
      DynFork::Globals.cache_mongo_client.close
    end
  end
end
