require "../spec_helper"

describe Crymon::Migration do
  describe "ModelState" do
    it "=> create instance without is_updated_state", tags: "migration" do
      ms = Crymon::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"}
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.is_updated_state?.should be_false
    end

    it "=> create instance with is_updated_state", tags: "migration" do
      ms = Crymon::Migration::ModelState.new(
        "collection_name": "ServiceName_ModelName",
        "field_name_and_type_list": {"field_name" => "TextField", "field_name_2" => "EmailField"},
        "is_updated_state": true
      )
      ms.collection_name.should eq("ServiceName_ModelName")
      ms.field_name_and_type_list.should eq({"field_name" => "TextField", "field_name_2" => "EmailField"})
      ms.is_updated_state?.should be_true
    end
  end

  describe "Monitor" do
    describe ".new" do
      it "=> create instance without database name", tags: "migration" do
        m = Crymon::Migration::Monitor.new(
          "app_name": "AppName",
          "unique_app_key": "0w7n5731X13s1641",
          "mongo_uri": "mongodb://localhost:27017",
          "model_key_list": [
            Helper::FilledModel.new.model_key,
            Helper::AuxiliaryModel.new.model_key,
          ]
        )
        #
        Crymon::Globals.cache_app_name.should eq("AppName")
        Crymon::Globals.cache_unique_app_key.should eq("0w7n5731X13s1641")
        Crymon::Globals.cache_database_name.should eq("AppName_0w7n5731X13s1641")
        #
        m.model_key_list.should eq(["ServiceName_FilledModel", "ServiceName_AuxiliaryModel"])
      end

      it "=> create instance with database name", tags: "migration" do
        m = Crymon::Migration::Monitor.new(
          "app_name": "AppName",
          "unique_app_key": "0585I0S5huR5r08q",
          "database_name": "DatabaseName360",
          "mongo_uri": "mongodb://localhost:27017",
          "model_key_list": [
            Helper::FilledModel.new.model_key,
            Helper::AuxiliaryModel.new.model_key,
          ]
        )
        #
        Crymon::Globals.cache_app_name.should eq("AppName")
        Crymon::Globals.cache_unique_app_key.should eq("0585I0S5huR5r08q")
        Crymon::Globals.cache_database_name.should eq("DatabaseName360")
        #
        m.model_key_list.should eq(["ServiceName_FilledModel", "ServiceName_AuxiliaryModel"])
      end

      it "=> create instance and testing model list", tags: "migration" do
        m = Crymon::Migration::Monitor.new(
          "app_name": "AppName",
          "unique_app_key": "0w7n5731X13s1641",
          "mongo_uri": "mongodb://localhost:27017",
          "model_key_list": [
            Helper::FilledModel.new.model_key,
            Helper::AuxiliaryModel.new.model_key,
          ]
        )
        #
        m.model_key_list.should eq(["ServiceName_FilledModel", "ServiceName_AuxiliaryModel"])
        #
        m.model_key_list.each do |model_key|
          metadata = Crymon::Globals.cache_metadata[model_key]
          metadata["service_name"].should eq("ServiceName")
        end
      end
    end

    describe ".refresh" do
      it "=> create instance and run refresh method", tags: "migration" do
        m = Crymon::Migration::Monitor.new(
          "app_name": "AppName",
          "unique_app_key": "070kI4s05i8F8uep",
          "mongo_uri": "mongodb://localhost:27017",
          "model_key_list": [
            Helper::FilledModel.new.model_key,
            Helper::AuxiliaryModel.new.model_key,
          ]
        )
        m.refresh.should be_nil
      end
    end
  end
end
