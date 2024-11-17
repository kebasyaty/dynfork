require "../../../../spec_helper"

describe DynFork::QCommons::Indexes do
  it "=> create and drop indexes", tags: "indexing" do
    # To generate a key (This is not an advertisement): https://randompasswordgen.com/
    unique_key = "171350nkyLzH5OC7"
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
    Spec::Data::ValueNoNil.create_indexes([
      {
        keys: {
          "text": 1,
        },
        options: {
          name: "textIdx",
        },
      },
    ]).nil?.should be_false
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
      m.file.from_path("public/media/default/no_doc.odt")
      m.image.from_path("public/media/default/no_photo.jpeg")
      #
      m.i64.value = 10_i64
      m.f64.value = 10.2
      #
      m.bool.value = true
      #
      m.save
    }
    #
    Spec::Data::ValueNoNil.drop_indexes.nil?.should be_false
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
