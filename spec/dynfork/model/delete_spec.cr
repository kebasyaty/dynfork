require "../../spec_helper"

describe DynFork::Model do
  describe "#delete" do
    it "=> remove a document from a collection", tags: "delete" do
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_key = "L1e4bxTuhriH99e3"
      database_name = "test_#{unique_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      mongo_client = Mongo::Client.new(mongo_uri)
      Spec::Support.delete_test_db(mongo_client[database_name])
      mongo_client.close

      # Run migration.
      m = DynFork::Migration::Monitor.new(
        database_name: database_name,
      )
      m.migrat
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
        DynFork::Globals.mongo_database)
      #
      DynFork::Globals.mongo_client.close
    end
  end
end
