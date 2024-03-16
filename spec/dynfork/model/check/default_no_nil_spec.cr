require "../../../spec_helper"

describe DynFork::Model do
  describe "#check" do
    it "=> validation of instance of `DefaultNoNil` model", tags: "check" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "7D553S9wrj05784z"
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
      m = Spec::Data::DefaultNoNil.new
      #
      # Get the collection for the current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        Spec::Data::DefaultNoNil.meta[:collection_name]]
      #
      output_data : DynFork::Globals::OutputData = m.check(pointerof(collection))
      valid = output_data.valid?
      m.print_err unless valid
      valid.should be_true
      data : BSON = output_data.data
      data.empty?.should be_true
      #
      # Param `value`
      m.url.value?.should be_nil
      m.text.value?.should be_nil
      m.phone.value?.should be_nil
      m.password.value?.should be_nil
      m.ip.value?.should be_nil
      m.hash.value?.should be_nil
      m.email.value?.should be_nil
      m.color.value?.should be_nil
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
      m.bool.value?.should be_nil
      #
      # Param `default`
      m.url.default?.should eq("https://translate.google.com/")
      m.text.default?.should eq("Some text")
      m.phone.default?.should eq("+18004444444")
      m.password.default?.should be_nil
      m.ip.default?.should eq("126.255.255.255")
      m.hash.default?.should be_nil
      m.email.default?.should eq("john.smith@example.com")
      m.color.default?.should eq("#ff0000")
      #
      m.date.default?.should eq("1970-01-01")
      m.datetime.default?.should eq("1970-01-01T00:00:00")
      #
      m.choice_text.default?.should eq("value")
      m.choice_text_mult.default?.should eq(["value"])
      m.choice_text_dyn.default?.should be_nil
      m.choice_text_mult_dyn.default?.should be_nil
      #
      m.choice_i64.default?.should eq(5_i64)
      m.choice_i64_mult.default?.should eq([5_i64])
      m.choice_i64_dyn.default?.should be_nil
      m.choice_i64_mult_dyn.default?.should be_nil
      #
      m.choice_f64.default?.should eq(5.0)
      m.choice_f64_mult.default?.should eq([5.0])
      m.choice_f64_dyn.default?.should be_nil
      m.choice_f64_mult_dyn.default?.should be_nil
      #
      m.file.default?.should eq("assets/media/default/no_doc.odt")
      m.image.default?.should eq("assets/media/default/no_photo.jpeg")
      #
      m.i64.default?.should eq(10_i64)
      m.f64.default?.should eq(10.2)
      #
      m.bool.default?.should be_true
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
