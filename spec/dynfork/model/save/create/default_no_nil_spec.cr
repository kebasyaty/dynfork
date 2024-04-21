require "../../../../spec_helper"

describe DynFork::Model do
  describe "#save-(create)" do
    it "=> validation of instance of `DefaultNoNil` model", tags: "save_create" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "924992B27o5zf40f"
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
      m = Spec::Data::DefaultNoNil.new
      flag : Bool = m.save
      m.print_err unless flag
      flag.should be_true
      #
      Spec::Data::DefaultNoNil.estimated_document_count.should eq(2) # + fixture
      #
      # Param `value`
      m.hash.value.empty?.should be_false
      m.created_at.value.empty?.should be_false
      m.updated_at.value.empty?.should be_false
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.created_at.value).should be_true
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.updated_at.value).should be_true
      #
      m.url.value?.should eq("https://translate.google.com/")
      m.text.value?.should eq("Some text")
      m.phone.value?.should eq("+18004444444")
      m.password.value?.should be_nil
      m.ip.value?.should eq("126.255.255.255")
      m.hash2.value?.should be_nil
      m.email.value?.should eq("john.smith@example.com")
      m.color.value?.should eq("#ff0000")
      m.slug.value?.should eq(m.hash.value?)
      #
      m.date.value?.should eq("1970-01-01")
      m.datetime.value?.should eq("1970-01-01T00:00:00")
      #
      m.choice_text.value?.should eq("value")
      m.choice_text_mult.value?.should eq(["value"])
      m.choice_text_dyn.value?.should be_nil
      m.choice_text_mult_dyn.value?.should be_nil
      #
      m.choice_i64.value?.should eq(5_i64)
      m.choice_i64_mult.value?.should eq([5_i64])
      m.choice_i64_dyn.value?.should be_nil
      m.choice_i64_mult_dyn.value?.should be_nil
      #
      m.choice_f64.value?.should eq(5.0)
      m.choice_f64_mult.value?.should eq([5.0])
      m.choice_f64_dyn.value?.should be_nil
      m.choice_f64_mult_dyn.value?.should be_nil
      #
      m.file.value.name.should eq("no_doc.odt")
      m.image.value.name.should eq("no_photo.jpeg")
      #
      m.i64.value?.should eq(10_i64)
      m.f64.value?.should eq(10.2)
      #
      m.bool.value?.should be_true
      #
      # Param `default`
      m.url.default?.should eq("https://translate.google.com/")
      m.text.default?.should eq("Some text")
      m.phone.default?.should eq("+18004444444")
      m.password.default?.should be_nil
      m.ip.default?.should eq("126.255.255.255")
      m.hash2.default?.should be_nil
      m.email.default?.should eq("john.smith@example.com")
      m.color.default?.should eq("#ff0000")
      m.slug.default?.should be_nil
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
