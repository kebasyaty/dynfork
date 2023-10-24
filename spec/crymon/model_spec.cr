require "../spec_helper"

describe Crymon do
  describe "Crymon::Model" do
    describe ".new" do
      it "create instance of empty Model" do
        m = Helper::EmptyModel.new
        m.model_name.should eq("EmptyModel")
        m.vars_count.should eq(0_i32)
        m.instance_vars_names.should eq(Array(String).new)
        m.instance_vars_types.should eq(Array(String).new)
        m.instance_vars_name_and_type.should eq(Hash(String, String).new)
        m.has_instance_var?("???").should be_false
      end

      it "create instance of empty Model" do
        m = Helper::FilledModel.new(name: "Gene", age: 50_u32)
        m.model_name.should eq("FilledModel")
        m.vars_count.should eq(2_i32)
        m.instance_vars_names.should eq(["name", "age"])
        m.instance_vars_types.should eq(["String", "UInt32"])
        m.instance_vars_name_and_type.should eq({"name" => "String", "age" => "UInt32"})
        m.has_instance_var?("name").should be_true
        m.has_instance_var?("age").should be_true
        m.has_instance_var?("???").should be_false
        m.name.should eq("Gene")
        m.age.should eq(50_u32)
      end
    end
  end
end
