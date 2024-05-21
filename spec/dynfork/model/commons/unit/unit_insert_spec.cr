require "../../../../spec_helper"

describe DynFork::Model do
  describe ".unit_manager" do
    it "=> insert and delete data", tags: "unit_add_del" do
      # Init data for test.
      #
      # To generate a key (This is not an advertisement): https://randompasswordgen.com/
      unique_app_key = "u9G58S073ms57RfD"
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
      # insert
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_dyn",
        title: "Title",
        value: "value",
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_dyn",
        title: "Title 2",
        value: "value 2",
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_mult_dyn",
        title: "Title",
        value: "value",
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_mult_dyn",
        title: "Title 2",
        value: "value 2",
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_dyn",
        title: "Title",
        value: 12_i64,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_dyn",
        title: "Title 2",
        value: 12_i64,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_mult_dyn",
        title: "Title",
        value: 12_i64,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_mult_dyn",
        title: "Title 2",
        value: 12_i64,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_dyn",
        title: "Title",
        value: 5.2,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_dyn",
        title: "Title 2",
        value: 5.2,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_mult_dyn",
        title: "Title",
        value: 5.2,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_mult_dyn",
        title: "Title 2",
        value: 5.2,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      # delete
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_dyn",
        title: "Title",
        value: "value",
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_dyn",
        title: "Title 2",
        value: "value 2",
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_mult_dyn",
        title: "Title",
        value: "value",
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_text_mult_dyn",
        title: "Title 2",
        value: "value 2",
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_dyn",
        title: "Title",
        value: 12_i64,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_dyn",
        title: "Title 2",
        value: 12_i64,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_mult_dyn",
        title: "Title",
        value: 12_i64,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_i64_mult_dyn",
        title: "Title 2",
        value: 12_i64,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_dyn",
        title: "Title",
        value: 5.2,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_dyn",
        title: "Title 2",
        value: 5.2,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_mult_dyn",
        title: "Title",
        value: 5.2,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
      #
      unit = DynFork::Globals::Unit.new(
        field: "choice_f64_mult_dyn",
        title: "Title 2",
        value: 5.2,
        delete: true,
      )
      Spec::Data::DynFieldsModel.unit_manager(unit).should be_nil
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
