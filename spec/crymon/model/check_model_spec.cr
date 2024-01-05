require "../../spec_helper"

describe Crymon::Model do
  describe "#is_valid" do
    it "=> validation instance of Model", tags: "validation" do
      # Init data for test.
      unique_app_key = Crymon::Tools::Test.generate_unique_app_key
      database_name = "test_#{unique_app_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      Crymon::Tools::Test.delete_test_db(
        Mongo::Client.new(mongo_uri)[database_name])

      # Run migration.
      Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": unique_app_key,
        "database_name": database_name,
        "mongo_uri": mongo_uri,
        "model_list": {
          Helper::FilledModel,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------

      # Testing is_valid method.
      m = Helper::FilledModel.new
      m.is_valid?.should be_true
      m.print_err.should be_nil

      # ------------------------------------------------------------------------
      #
      # Delete database after test.
      Crymon::Tools::Test.delete_test_db(
        Crymon::Globals.cache_mongo_database.not_nil!)
    end
  end
end
