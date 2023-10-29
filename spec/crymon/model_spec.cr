require "../spec_helper"

describe Crymon::Model do
  describe ".new" do
    it "=> create instance of empty Model" do
      ex = expect_raises(Crymon::Errors::FieldsMissing) do
        Helper::EmptyModel.new.meta
      end
      ex.message.should eq(%(Model "EmptyModel" has no fields.))
    end

    it "=> create instance of filled Model" do
      m = Helper::FilledModel.new(name: "Gene", age: 32_u32)
      m.model_key.should eq("ServiceName_FilledModel_RT0839370A074kVh")
      m.[]?("name").should be_true
      m.[]?("age").should be_true
      m.[]?("birthday").should be_true
      m.[]?("???").should be_false
      m.name.should eq("Gene")
      m.age.should eq(32_u32)
      m.birthday.should eq(Helper::Birthday.new)
      m.birthday.date.should eq("1990-11-7")
      m.birthday.value.should eq("")
      m.birthday.value = "Hello world!"
      m.birthday.value.should eq("Hello world!")
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
      metadata["field_type_list"].should eq(["String", "UInt32", "Birthday"])
      metadata["field_name_and_type_list"].should eq(
        {"name" => "String", "age" => "UInt32", "birthday" => "Birthday"}
      )
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
          Helper::NoParamAppNameModel.new(name: "Gene", age: 32_u32).meta
        end
        ex.message.should eq(%(Missing "app_name" parameter for Metadata.))
      end

      it "=> Model without mandatory 'unique_app_key' parameter for metadata" do
        ex = expect_raises(Crymon::Errors::ParameterMissing) do
          Helper::NoParamUniqueAppKeyModel.new(name: "Gene", age: 32_u32).meta
        end
        ex.message.should eq(%(Missing "unique_app_key" parameter for Metadata.))
      end

      it "=> Model without mandatory 'service_name' parameter for metadata" do
        ex = expect_raises(Crymon::Errors::ParameterMissing) do
          Helper::NoParamServiceMameModel.new(name: "Gene", age: 32_u32).meta
        end
        ex.message.should eq(%(Missing "service_name" parameter for Metadata.))
      end

      it "=> the names in the list of ignored fields do not match" do
        ex = expect_raises(Crymon::Errors::IgnoredFieldMissing) do
          Helper::IncorrectIgnoredListModel.new(name: "Gene", age: 32_u32).meta
        end
        ex.message.should eq(%(The "birthday" field is missing from the list of ignored fields.))
      end
    end
  end
end
