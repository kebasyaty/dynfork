require "../spec_helper"

describe Crymon::Model do
  describe ".new" do
    it "=> create instance of empty Model" do
      ex = expect_raises(Crymon::Errors::FieldsMissing) do
        Helper::EmptyModel.new
      end
      ex.message.should eq(%(Model "EmptyModel" has no fields.))
    end

    it "=> create instance of filled Model" do
      m = Helper::FilledModel.new
      #
      m.model_key.should eq("ServiceName_FilledModel")
      #
      m["name"]?.should be_true
      m["age"]?.should be_true
      m["birthday"]?.should be_true
      m["???"]?.should be_false
      #
      m.name.id.should eq("FilledModel--name")
      m.name.name.should eq("name")
      m.age.id.should eq("FilledModel--age")
      m.age.name.should eq("age")
      m.birthday.id.should eq("FilledModel--birthday")
      m.birthday.name.should eq("birthday")
      #
      m.name.value = "Gene"
      m.age.value = 32
      m.birthday.value = "1990-11-7"
      #
      m.name.value.should eq("Gene")
      m.age.value.should eq(32_u32)
      m.birthday.value.should eq("1990-11-7")
      # Testing metadata.
      metadata = m.meta
      metadata["app_name"].should eq(Settings::APP_NAME)
      metadata["model_name"].should eq("FilledModel")
      metadata["unique_app_key"].should eq(Settings::UNIQUE_APP_KEY)
      metadata["service_name"].should eq(Settings::SERVICE_NAME)
      metadata["database_name"].should eq("AppName_RT0839370A074kVh")
      metadata["collection_name"].should eq("ServiceName_FilledModel")
      metadata["db_query_docs_limit"].should eq(2000_u32)
      metadata["field_count"].should eq(3_i32)
      metadata["field_name_list"].should eq(["name", "age", "birthday"])
      metadata["field_type_list"].should eq(["TextField", "U32Field", "DateField"])
      metadata["field_name_and_type_list"].should eq(
        {"name" => "TextField", "age" => "U32Field", "birthday" => "DateField"}
      )
      metadata["default_value_list"].should eq({"name" => "Cat", "age" => 0, "birthday" => "0000-00-00"})
      metadata["is_add_doc"].should be_true
      metadata["is_up_doc"].should be_true
      metadata["is_del_doc"].should be_true
      metadata["is_use_addition"].should be_false
      metadata["is_use_hooks"].should be_false
      metadata["is_use_hash_slug"].should be_false
      metadata["ignore_fields"].should eq(["age", "birthday"])
    end

    describe "#meta" do
      it "=> Model without mandatory 'app_name' parameter for metadata" do
        ex = expect_raises(Crymon::Errors::ParameterMissing) do
          Helper::NoParamAppNameModel.new.meta
        end
        ex.message.should eq(%(Missing "app_name" parameter for Metadata.))
      end

      it "=> Model without mandatory 'unique_app_key' parameter for metadata" do
        ex = expect_raises(Crymon::Errors::ParameterMissing) do
          Helper::NoParamUniqueAppKeyModel.new.meta
        end
        ex.message.should eq(%(Missing "unique_app_key" parameter for Metadata.))
      end

      it "=> Model without mandatory 'service_name' parameter for metadata" do
        ex = expect_raises(Crymon::Errors::ParameterMissing) do
          Helper::NoParamServiceMameModel.new.meta
        end
        ex.message.should eq(%(Missing "service_name" parameter for Metadata.))
      end

      it "=> the names in the list of ignored fields do not match" do
        ex = expect_raises(Crymon::Errors::IgnoredFieldMissing) do
          Helper::IncorrectIgnoredListModel.new.meta
        end
        ex.message.should eq(%(The "birthday" field is missing from the list of ignored fields.))
      end
    end
  end
end
