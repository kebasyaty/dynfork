require "../../../spec_helper"

describe DynFork::Model do
  describe "self.unit_manager" do
    it "=> call class method", tags: "unit" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "UcD0V8JT5gY1s8G0"
      database_name = "test_#{unique_app_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      Spec::Support.delete_test_db(
        Mongo::Client.new(mongo_uri)[database_name])

      # Run migration.
      DynFork::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": unique_app_key,
        "database_name": database_name,
        "mongo_uri": mongo_uri,
        "model_list": {
          Spec::Data::UnitModel,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      unit = DynFork::Globals::Unit.new(
        field: "field_name",
        title: "Title",
        value: "value",
        delete: true
      )
      Spec::Data::UnitModel.unit_manager(unit).should be_nil
      # ------------------------------------------------------------------------
      #
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
      #
      DynFork::Globals.cache_mongo_client.close
    end
  end
end
