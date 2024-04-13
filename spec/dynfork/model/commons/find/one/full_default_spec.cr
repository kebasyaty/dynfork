require "../../../../../spec_helper"

describe DynFork::Model do
  describe "Find One" do
    it "=> from an empty collection", tags: "find_one" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "ik83sDFW1Gp916L3"
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
          Spec::Data::FullDefault,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      instance = Spec::Data::FullDefault.find_one_to_instance
      instance.should be_nil
      #
      json : String = Spec::Data::FullDefault.find_one_to_json
      json.empty?.should be_true
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
