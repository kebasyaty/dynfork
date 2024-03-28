require "../../../spec_helper"

describe DynFork::Model do
  describe "#update_password" do
    it "=> update password in database", tags: "update_password" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "7x553USYlwB44qi5"
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
      password = "9M,4%6]3ht7r{l59"
      new_password = "2XT~m:L!Hz_723J("
      m.username.value = "username"
      m.password.value = password
      #
      flag : Bool = m.save?
      m.print_err unless flag
      flag.should be_true
      #
      # Negative
      ex = expect_raises(DynFork::Errors::Password::OldPassNotMatch) do
        m.update_password(
          old_password: "d6'P30}e'#f^g3t5",
          new_password: new_password
        )
      end
      ex.message.should eq(I18n.t(:old_pass_not_match))
      # Positive
      m.update_password(
        old_password: password,
        new_password: new_password
      ).should be_nil
      m.verify_password?(new_password).should be_true
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
