require "../../../../../spec_helper"

describe DynFork::Model do
  describe ".find_many_to_hash_list" do
    it "=> find documents", tags: "find_many" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "r4cAr8z2XF6S3h0x"
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
          Spec::Data::DefaultNoNil,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      arr : Array(Hash(String, DynFork::Globals::ValueTypes)) = Spec::Data::DefaultNoNil.find_many_to_hash_list
      arr.empty?.should be_true
      #
      Spec::Data::DefaultNoNil.new
      Spec::Data::DefaultNoNil.new
      Spec::Data::DefaultNoNil.count_documents.should eq(2)
      Spec::Data::DefaultNoNil.estimated_document_count.should eq(2)
      #
      arr = Spec::Data::DefaultNoNil.find_many_to_hash_list
      arr.size.should eq 2
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
