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
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      m = Spec::Data::UpdatePassword.new
      password = "WO:4J_'2G#~$H4bx"
      m.username.value = "username"
      m.password.value = password
      #
      flag : Bool = m.save
      m.print_err unless flag
      flag.should be_true
      #
      # Negative
      m.verify_password?("cH!29_#_5iBj}C41").should be_false
      # Positive
      m.verify_password?(password).should be_true
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
