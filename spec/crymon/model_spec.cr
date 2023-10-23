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
    end
  end
end
