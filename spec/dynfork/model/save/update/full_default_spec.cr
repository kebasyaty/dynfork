require "../../../../spec_helper"

describe DynFork::Model do
  describe "#save-(update)" do
    it "=> validation of instance of `FullDefault` model", tags: "save_update" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "G89m9oRruiM615r5"
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
      # Create
      m = Spec::Data::FullDefault.new
      flag : Bool = m.save?
      m.print_err unless flag
      flag.should be_true
      m.color.value?.should eq("#000000")
      # Update
      m.color.value = "#ff0000"
      flag = m.save?
      m.print_err unless flag
      flag.should be_true
      #
      Spec::Data::FullDefault.estimated_document_count.should eq(1)
      #
      # Param `value`
      m.hash.value.empty?.should be_false
      m.created_at.value.empty?.should be_false
      m.updated_at.value.empty?.should be_false
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.created_at.value).should be_true
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.updated_at.value).should be_true
      #
      m.url.value?.should be_nil
      m.text.value?.should be_nil
      m.phone.value?.should be_nil
      m.password.value?.should be_nil
      m.ip.value?.should be_nil
      m.hash2.value?.should be_nil
      m.email.value?.should be_nil
      m.color.value?.should eq("#ff0000")
      m.slug.value?.should eq(m.hash.value?)
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
      m.slug.default?.should be_nil
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
      FileUtils.rm_rf("assets/media/files")
      FileUtils.rm_rf("assets/media/images")
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
