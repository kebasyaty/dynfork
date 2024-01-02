require "../spec_helper"

describe Crymon::Migration::ModelState do
  describe ".new" do
    it "=> create instance without is_model_exists", tags: "migration" do
      ms = Crymon::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"}
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.is_model_exists?.should be_false
    end

    it "=> create instance with is_model_exists", tags: "migration" do
      ms = Crymon::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"},
        "is_model_exists": true
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.is_model_exists?.should be_true
    end
  end
end

describe Crymon::Migration::Monitor do
  describe ".new" do
    it "=> create instance without database name", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Helper::FilledModel,
          Helper::AuxiliaryModel,
        }
      )
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("0w7n5731X13s1641")
      Crymon::Globals.cache_database_name.should eq("AppName_0w7n5731X13s1641")
      #
      m.model_list.should eq({Helper::FilledModel, Helper::AuxiliaryModel})
    end

    it "=> create instance with database name", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0585I0S5huR5r08q",
        "database_name": "DatabaseName360",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Helper::FilledModel,
          Helper::AuxiliaryModel,
        }
      )
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("0585I0S5huR5r08q")
      Crymon::Globals.cache_database_name.should eq("DatabaseName360")
      #
      m.model_list.should eq({Helper::FilledModel, Helper::AuxiliaryModel})
    end

    it "=> create instance and testing model list", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Helper::FilledModel,
          Helper::AuxiliaryModel,
        }
      )
      #
      m.model_list.should eq({Helper::FilledModel, Helper::AuxiliaryModel})
    end
  end

  describe "#migrat" do
    it "=> run migration process", tags: "migration" do
      # Generate data for test.
      test_data = Crymon::Tools::Test.generate_test_data
      unique_app_key = test_data[:unique_app_key]
      database_name = test_data[:database_name]

      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": unique_app_key,
        "database_name": database_name,
        "mongo_uri": "mongodb://localhost:27017",
        "model_list": {
          Helper::FilledModel,
          Helper::AuxiliaryModel,
        }
      )
      m.migrat.should be_nil

      # Get database.
      database = Crymon::Globals.cache_mongo_database.not_nil!
      # Delete database after test.
      Crymon::Tools::Test.delete_test_db(database)
    end
  end
end
