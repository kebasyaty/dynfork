require "../../spec_helper"

describe DynFork::Model do
  describe "#delete" do
    it "=> remove a document from a collection", tags: "delete" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "L1e4bxTuhriH99e3"
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
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      m = Spec::Data::DeleteModel.new
      m.username.value = "username"
      m.password.value = "E2ep4e3UPkWs84GO"
      #
      flag : Bool = m.save
      m.print_err unless flag
      flag.should be_true
      #
      Spec::Data::DeleteModel.count_documents.should eq(1)
      m.delete
      Spec::Data::DeleteModel.estimated_document_count.should eq(0)
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
