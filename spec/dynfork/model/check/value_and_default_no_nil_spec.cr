require "../../../spec_helper"

describe DynFork::Model do
  describe "#check" do
    it "=> validation of instance of `ValueAndDefaultNoNil` model", tags: "check" do
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_key = "31623nJu4ALc8006"
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
      m = Spec::Data::ValueAndDefaultNoNil.new
      #
      # Init `value`
      m.url.value = "https://translate.google.com/"
      m.text.value = "Some text"
      m.phone.value = "+18004444444"
      m.password.value = "E2ep4e3UPkWs84GO"
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
      m.file.from_path("public/media/default/no_doc.odt")
      m.image.from_path("public/media/default/no_photo.jpeg")
      #
      m.i64.value = 10_i64
      m.f64.value = 10.2
      #
      m.bool.value = true
      #
      # Get the collection for the current model.
      collection : Mongo::Collection = DynFork::Globals.mongo_database[
        Spec::Data::ValueAndDefaultNoNil.meta[:collection_name]]
      #
      output_data : DynFork::Globals::OutputData = m.check(pointerof(collection))
      valid = output_data.valid?
      m.print_err unless valid
      valid.should be_true
      data : Hash(String, DynFork::Globals::ResultMapType) = output_data.data
      data.empty?.should be_true
      #
      # Param `value`
      m.url.value?.should eq("https://translate.google.com/")
      m.text.value?.should eq("Some text")
      m.phone.value?.should eq("+18004444444")
      m.password.value?.should eq("E2ep4e3UPkWs84GO")
      m.ip.value?.should eq("126.255.255.255")
      m.hash2.value?.should eq("507c7f79bcf86cd7994f6c0e")
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
      m.file.default?.should eq("public/media/default/no_doc.odt")
      m.image.default?.should eq("public/media/default/no_photo.jpeg")
      #
      m.i64.default?.should eq(10_i64)
      m.f64.default?.should eq(10.2)
      #
      m.bool.default?.should be_true
      #
      FileUtils.rm_rf("public/media/uploads/files")
      FileUtils.rm_rf("public/media/uploads/images")
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
