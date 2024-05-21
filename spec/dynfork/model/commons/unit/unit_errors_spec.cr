require "../../../../spec_helper"

describe DynFork::Model do
  describe ".unit_manager" do
    it "=> validation of unit", tags: "unit_errors" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "UcD0V8JT5gY1s8G0"
      database_name = "test_#{unique_app_key}"
      mongo_uri = "mongodb://localhost:27017"

      # Delete database before test.
      # (if the test fails)
      Spec::Support.delete_test_db(
        Mongo::Client.new(mongo_uri)[database_name])

      # Run migration.
      DynFork::Migration::Monitor.new(
        app_name: "AppName",
        unique_app_key: unique_app_key,
        database_name: database_name,
        mongo_client: Mongo::Client.new(mongo_uri)
      ).migrat
      #
      # HELLISH BURN
      # ------------------------------------------------------------------------
      # If the field `field` is empty?
      ex = expect_raises(DynFork::Errors::Panic) do
        unit = DynFork::Globals::Unit.new(
          field: "",
          title: "Title",
          value: "value",
          delete: true,
        )
        Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      end
      ex.message.should eq "Model: `Spec::Data::DynFieldsModel` > " +
                           "Method: `.unit_manager` > Argument: `unit` > " +
                           "Field `field` => must not be empty!"
      #
      # If the field `title` is empty?
      ex = expect_raises(DynFork::Errors::Panic) do
        unit = DynFork::Globals::Unit.new(
          field: "field_name",
          title: "",
          value: "value",
          delete: true,
        )
        Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      end
      ex.message.should eq "Model: `Spec::Data::DynFieldsModel` > " +
                           "Method: `.unit_manager` > Argument: `unit` > " +
                           "Field `title` => must not be empty!"
      # If the field `value` is empty?
      ex = expect_raises(DynFork::Errors::Panic) do
        unit = DynFork::Globals::Unit.new(
          field: "field_name",
          title: "Title",
          value: "",
          delete: true,
        )
        Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      end
      ex.message.should eq "Model: `Spec::Data::DynFieldsModel` > " +
                           "Method: `.unit_manager` > Argument: `unit` > " +
                           "Field `value` => must not be empty!"
      # If the Model does not have a dynamic field specified in the Unit.
      ex = expect_raises(DynFork::Errors::Panic) do
        unit = DynFork::Globals::Unit.new(
          field: "field_name",
          title: "Title",
          value: "value",
          delete: true,
        )
        Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      end
      ex.message.should eq "Model: `Spec::Data::DynFieldsModel` > " +
                           "Method: `.unit_manager` => " +
                           "The Model is missing a dynamic field `field_name`!"
      # When try to delete data that doesn't exist.
      ex = expect_raises(DynFork::Errors::Panic) do
        unit = DynFork::Globals::Unit.new(
          field: "choice_text_dyn",
          title: "Title",
          value: "value",
          delete: true,
        )
        Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      end
      ex.message.should eq "Model: `Spec::Data::DynFieldsModel` > " +
                           "Method: `.unit_manager` => " +
                           "It is impossible to delete a unit, the `Title` key is missing!"
      #
      FileUtils.rm_rf("assets/media/uploads/files")
      FileUtils.rm_rf("assets/media/uploads/images")
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
