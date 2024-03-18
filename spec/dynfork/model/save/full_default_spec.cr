require "../../../spec_helper"

describe DynFork::Model do
  describe "#save" do
    it "=> validation of instance of `FullDefault` model", tags: "save" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "1DO19i56v37M91Y0"
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
      m = Spec::Data::FullDefault.new
      if output_data : DynFork::Globals::OutputData? = m.save
        valid = output_data.valid?
        m.print_err unless valid
        valid.should be_true
        data : BSON = output_data.data
        data.empty?.should be_false
      end
      #
      # Param `value`
      m.url.value?.should be_nil
      m.text.value?.should be_nil
      m.phone.value?.should be_nil
      m.password.value?.should be_nil
      m.ip.value?.should be_nil
      m.hash2.value?.should be_nil
      m.email.value?.should be_nil
      m.color.value?.should eq("#000000")
      #
      m.date.value?.should be_nil
      m.datetime.value?.should be_nil
      #
      m.choice_text.value?.should be_nil
      m.choice_text_mult.value?.should be_nil
      m.choice_text_dyn.value?.should be_nil
      m.choice_text_mult_dyn.value?.should be_nil
      #
      m.choice_i64.value?.should be_nil
      m.choice_i64_mult.value?.should be_nil
      m.choice_i64_dyn.value?.should be_nil
      m.choice_i64_mult_dyn.value?.should be_nil
      #
      m.choice_f64.value?.should be_nil
      m.choice_f64_mult.value?.should be_nil
      m.choice_f64_dyn.value?.should be_nil
      m.choice_f64_mult_dyn.value?.should be_nil
      #
      m.file.value?.should be_nil
      m.image.value?.should be_nil
      #
      m.i64.value?.should be_nil
      m.f64.value?.should be_nil
      #
      m.bool.value?.should be_false
      #
      # Param `default`
      m.url.default?.should be_nil
      m.text.default?.should be_nil
      m.phone.default?.should be_nil
      m.password.default?.should be_nil
      m.ip.default?.should be_nil
      m.hash2.default?.should be_nil
      m.email.default?.should be_nil
      m.color.default?.should eq("#000000")
      #
      m.date.default?.should be_nil
      m.datetime.default?.should be_nil
      #
      m.choice_text.default?.should be_nil
      m.choice_text_mult.default?.should be_nil
      m.choice_text_dyn.default?.should be_nil
      m.choice_text_mult_dyn.default?.should be_nil
      #
      m.choice_i64.default?.should be_nil
      m.choice_i64_mult.default?.should be_nil
      m.choice_i64_dyn.default?.should be_nil
      m.choice_i64_mult_dyn.default?.should be_nil
      #
      m.choice_f64.default?.should be_nil
      m.choice_f64_mult.default?.should be_nil
      m.choice_f64_dyn.default?.should be_nil
      m.choice_f64_mult_dyn.default?.should be_nil
      #
      m.file.default?.should be_nil
      m.image.default?.should be_nil
      #
      m.i64.default?.should be_nil
      m.f64.default?.should be_nil
      #
      m.bool.default?.should be_false
      #
      #
      m.file.delete_tempfile
      m.image.delete_tempfile
      # ------------------------------------------------------------------------
      #
      # Delete database after test.
      Spec::Support.delete_test_db(
        DynFork::Globals.cache_mongo_database)
    end
  end
end
