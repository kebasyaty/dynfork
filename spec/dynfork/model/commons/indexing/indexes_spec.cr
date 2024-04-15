require "../../../../spec_helper"

describe DynFork::Commons::Indexes do
  it "=> create and drop indexes", tags: "indexing" do
    # Init data for test.
    #
    # To generate a key (This is not an advertisement): https://randompasswordgen.com/
    unique_app_key = "171350nkyLzH5OC7"
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
    Spec::Data::ValueNoNil.create_indexes(
      {
        keys: {
          "text": 1,
        },
        options: {
          name: "textIdx",
        },
      },
    ).not_nil!.ok.should eq 1.0
    #
    2.times { |idx|
      m = Spec::Data::ValueNoNil.new
      #
      # Init `value`
      m.url.value = "https://translate.google.com/"
      m.text.value = "Some text #{idx + 1}"
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
      m.choice_text_dyn.value = nil
      m.choice_text_mult_dyn.value = nil
      #
      m.choice_i64.value = 5_i64
      m.choice_i64_mult.value = [5_i64]
      m.choice_i64_dyn.value = nil
      m.choice_i64_mult_dyn.value = nil
      #
      m.choice_f64.value = 5.0
      m.choice_f64_mult.value = [5.0]
      m.choice_f64_dyn.value = nil
      m.choice_f64_mult_dyn.value = nil
      #
      m.file.from_path("assets/media/default/no_doc.odt")
      m.image.from_path("assets/media/default/no_photo.jpeg")
      #
      m.i64.value = 10_i64
      m.f64.value = 10.2
      #
      m.bool.value = true
      #
      m.save
    }
    #
    Spec::Data::ValueNoNil.drop_indexes.not_nil!.ok.should eq 1.0
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
