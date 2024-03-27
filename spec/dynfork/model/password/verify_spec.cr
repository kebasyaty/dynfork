require "../../../spec_helper"

describe DynFork::Model do
  describe "#verify_password" do
    it "=> match the password with the password in the database", tags: "verify_password" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "XMl7976GO666b712"
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
          Spec::Data::UpdatePassword,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      m = Spec::Data::UpdatePassword.new
      password = "E2ep4e3UPkWs84GO"
      m.username.value = "username"
      m.password.value = password
      #
      flag : Bool = m.save?
      m.print_err unless flag
      flag.should be_true
      #
      m.verify_password("XMl7976GO666b712").should be_false
      m.verify_password(password).should be_true
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
