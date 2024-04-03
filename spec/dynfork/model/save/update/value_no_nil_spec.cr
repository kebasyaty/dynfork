require "../../../../spec_helper"

describe DynFork::Model do
  describe "#save-(update)" do
    it "=> validation of instance of `ValueNoNil` model", tags: "save_update" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "Oi074E75420IA6BZ"
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
          Spec::Data::ValueNoNil,
        }
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      # Create
      m = Spec::Data::ValueNoNil.new
      #
      # Init `value`
      m.url.value = "https://translate.google.com/"
      m.text.value = "Some text"
      m.phone.value = "+18004444444"
      m.password.value = "7637Kw8#5GTb~]H#"
      m.ip.value = "126.255.255.255"
      m.hash2.value = "507c7f79bcf86cd7994f6c0e"
      m.email.value = "john.smith@example.com"
      m.color.value = "#ff0000"
      #
      m.date.value = "1970-01-01"
      m.datetime.value = "1970-01-01T00:00:00"
      #
      m.choice_text.value = "value"
      m.choice_text_mult.value = ["value"]
      m.choice_text_dyn.value?.should be_nil
      m.choice_text_mult_dyn.value?.should be_nil
      #
      m.choice_i64.value = 5_i64
      m.choice_i64_mult.value = [5_i64]
      m.choice_i64_dyn.value?.should be_nil
      m.choice_i64_mult_dyn.value?.should be_nil
      #
      m.choice_f64.value = 5.0
      m.choice_f64_mult.value = [5.0]
      m.choice_f64_dyn.value?.should be_nil
      m.choice_f64_mult_dyn.value?.should be_nil
      #
      m.file.from_path("assets/media/default/no_doc.odt")
      m.image.from_path("assets/media/default/no_photo.jpeg")
      #
      m.i64.value = 10_i64
      m.f64.value = 10.2
      #
      m.bool.value = true
      #
      #
      flag : Bool = m.save?
      m.print_err unless flag
      flag.should be_true
      m.color.value?.should eq("#ff0000")
      #
      m.count_documents.should eq(1)
      # Update
      m.url.value = "https://randompasswordgen.com/"
      m.phone.value = "+18004444455"
      m.ip.value = "124.255.255.255"
      m.hash2.value = "607c7f79bcf86cd7994f6c01"
      m.email.value = "gene.cost@example.com"
      m.color.value = "#340000"
      m.date.value = "2024-03-23"
      m.datetime.value = "2024-03-23T07:46:00"
      m.choice_text.value = "value 2"
      m.choice_text_mult.value = ["value 2"]
      m.choice_i64.value = 10_i64
      m.choice_i64_mult.value = [5_i64, 10_i64]
      m.choice_f64.value = 5.25
      m.choice_f64_mult.value = [5.0, 5.25]
      m.file.from_path(delete: true)
      m.image.from_path("pictures/pluto_3.webp")
      m.i64.value = 20_i64
      m.f64.value = 20.2
      m.bool.value = false
      #
      flag = m.save?
      m.print_err unless flag
      flag.should be_true
      #
      #
      m.count_documents.should eq(1)
      #
      # Param `value`
      m.hash.value.empty?.should be_false
      m.created_at.value.empty?.should be_false
      m.updated_at.value.empty?.should be_false
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.created_at.value).should be_true
      DynFork::Globals.cache_regex[:datetime_parse_reverse].matches?(m.updated_at.value).should be_true
      #
      m.url.value?.should eq("https://randompasswordgen.com/")
      m.text.value?.should eq("Some text")
      m.phone.value?.should eq("+18004444455")
      m.password.value?.should be_nil
      m.ip.value?.should eq("124.255.255.255")
      m.hash2.value?.should eq("607c7f79bcf86cd7994f6c01")
      m.email.value?.should eq("gene.cost@example.com")
      m.color.value?.should eq("#340000")
      m.slug.value?.should eq(m.hash.value?)
      #
      m.date.value?.should eq("2024-03-23")
      m.datetime.value?.should eq("2024-03-23T07:46:00")
      #
      m.choice_text.value?.should eq("value 2")
      m.choice_text_mult.value?.should eq(["value 2"])
      m.choice_text_dyn.value?.should be_nil
      m.choice_text_mult_dyn.value?.should be_nil
      #
      m.choice_i64.value?.should eq(10_i64)
      m.choice_i64_mult.value?.should eq([5_i64, 10_i64])
      m.choice_i64_dyn.value?.should be_nil
      m.choice_i64_mult_dyn.value?.should be_nil
      #
      m.choice_f64.value?.should eq(5.25)
      m.choice_f64_mult.value?.should eq([5.0, 5.25])
      m.choice_f64_dyn.value?.should be_nil
      m.choice_f64_mult_dyn.value?.should be_nil
      #
      m.file.value.should be_nil
      m.image.value.name.should eq("pluto_3.webp")
      #
      m.i64.value?.should eq(20_i64)
      m.f64.value?.should eq(20.2)
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
