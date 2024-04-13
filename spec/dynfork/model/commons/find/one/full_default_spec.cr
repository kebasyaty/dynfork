require "../../../../../spec_helper"

describe DynFork::Model do
  describe ".find_one_to_instance" do
    # Init data for test.
    #
    # To generate a key (This is not an advertisement): https://randompasswordgen.com/
    unique_app_key = "2tx8799Br0710XDM"
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
    it "=> from an empty database", tags: "find_one" do
      Spec::Data::FullDefault.find_one_to_instance.should be_nil
    end
    # ------------------------------------------------------------------------
    #
    # Delete database after test.
    Spec::Support.delete_test_db(
      DynFork::Globals.cache_mongo_database)
    #
    DynFork::Globals.cache_mongo_client.close
  end
end