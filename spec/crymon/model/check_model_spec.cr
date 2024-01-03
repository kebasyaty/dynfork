require "../../spec_helper"

describe Crymon::Model do
  describe "#is_valid" do
    it "=> validation instance of Model", tags: "validation" do
      # Generate data for test.
      test_data = Crymon::Tools::Test.generate_test_data

      Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": test_data[:unique_app_key],
        "database_name": test_data[:database_name],
        "mongo_uri": "mongodb://localhost:27017",
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
