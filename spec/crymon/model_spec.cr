require "../spec_helper"

describe Crymon::Model do
  describe ".new" do
    it "=> create instance of empty Model", tags: "model" do
      ex = expect_raises(Crymon::Errors::ModelFieldsMissing) do
        Helper::EmptyModel.new
      end
      ex.message.should eq(%(Model "EmptyModel" has no fields.))
    end

    it "=> create instance of filled Model", tags: "model" do
      m = Helper::FilledModel.new
      #
      m.model_key.should eq("ServiceName_FilledModel")
      #
      m["first_name"]?.should be_true
      m["age"]?.should be_true
      m["birthday"]?.should be_true
      m["hash"]?.should be_true
      m["created_at"]?.should be_true
      m["updated_at"]?.should be_true
      m["???"]?.should be_false
      #
      m.first_name.id.should eq("FilledModel--first-name")
      m.first_name.name.should eq("first_name")
      m.age.id.should eq("FilledModel--age")
      m.age.name.should eq("age")
      m.birthday.id.should eq("FilledModel--birthday")
      m.birthday.name.should eq("birthday")
      m.hash.id.should eq("FilledModel--hash")
      m.hash.name.should eq("hash")
      m.created_at.id.should eq("FilledModel--created-at")
      m.created_at.name.should eq("created_at")
      m.updated_at.id.should eq("FilledModel--updated-at")
      m.updated_at.name.should eq("updated_at")
      #
      m.first_name.value = "Gene"
      m.age.value = 32
      m.birthday.value = "1990-11-7"
      m.hash.value = "507f191e810c19729de860ea"
      m.created_at.value = "2023-11-02"
      m.updated_at.value = "2023-11-02"
      #
      m.first_name.value.should eq("Gene")
      m.age.value.should eq(32_u32)
      m.hash.value.should eq("507f191e810c19729de860ea")
      m.created_at.value.should eq("2023-11-02")
      m.updated_at.value.should eq("2023-11-02")
      # Testing metadata.
      metadata = Crymon::Globals.store[m.model_key]
      metadata["app_name"].should eq(Settings::APP_NAME)
      metadata["model_name"].should eq("FilledModel")
      metadata["unique_app_key"].should eq(Settings::UNIQUE_APP_KEY)
      metadata["service_name"].should eq(Settings::SERVICE_NAME)
      metadata["database_name"].should eq("AppName_RT0839370A074kVh")
      metadata["collection_name"].should eq("ServiceName_FilledModel")
      metadata["db_query_docs_limit"].should eq(2000_u32)
      metadata["field_count"].should eq(6_i32)
      metadata["field_name_list"].should eq(
        ["hash", "created_at", "updated_at", "first_name", "age", "birthday"]
      )
      metadata["field_type_list"].should eq(
        ["HashField",
         "DateTimeField",
         "DateTimeField",
         "TextField",
         "U32Field",
         "DateField"]
      )
      metadata["field_name_and_type_list"].should eq(
        {"hash"       => "HashField",
         "created_at" => "DateTimeField",
         "updated_at" => "DateTimeField",
         "first_name" => "TextField",
         "age"        => "U32Field",
         "birthday"   => "DateField"}
      )
      metadata["default_value_list"].should eq(
        {"hash"       => nil,
         "created_at" => nil,
         "updated_at" => nil,
         "first_name" => "Cat",
         "age"        => 0,
         "birthday"   => "0000-00-00"}
      )
      metadata["is_add_doc"].should be_true
      metadata["is_up_doc"].should be_true
      metadata["is_del_doc"].should be_true
      metadata["is_use_addition"].should be_false
      metadata["is_use_hooks"].should be_false
      metadata["is_use_hash_slug"].should be_false
      metadata["ignore_fields"].should eq(["age", "birthday"])
    end

    it "=> create instance of Model with a predefined database name", tags: "model" do
      m = Helper::ParamDBNameModel.new
      metadata = Crymon::Globals.store[m.model_key]
      metadata["database_name"].should eq("DatabaseName360")
    end

    describe "#caching" do
      it "=> Model without mandatory 'app_name' parameter for metadata", tags: "model" do
        ex = expect_raises(Crymon::Errors::MetaParameterMissing) do
          Helper::NoParamAppNameModel.new
        end
        ex.message.should eq(%(Model: NoParamAppNameModel => Missing "app_name" parameter for Meta.))
      end

      it "=> Model without mandatory 'unique_app_key' parameter for metadata", tags: "model" do
        ex = expect_raises(Crymon::Errors::MetaParameterMissing) do
          Helper::NoParamUniqueAppKeyModel.new
        end
        ex.message.should eq(%(Model: NoParamUniqueAppKeyModel => Missing "unique_app_key" parameter for Meta.))
      end

      it "=> Model without mandatory 'service_name' parameter for metadata", tags: "model" do
        ex = expect_raises(Crymon::Errors::MetaParameterMissing) do
          Helper::NoParamServiceMameModel.new
        end
        ex.message.should eq(%(Model: NoParamServiceMameModel => Missing "service_name" parameter for Meta.))
      end

      it "=> the names in the list of ignored fields do not match", tags: "model" do
        ex = expect_raises(Crymon::Errors::MetaIgnoredFieldMissing) do
          Helper::IncorrectIgnoredListModel.new
        end
        ex.message.should eq(%(Model: IncorrectIgnoredListModel > Meta parameter: "ignore_fields" => The "birthday" field is missing from the list of ignored fields.))
      end
    end
  end
end
