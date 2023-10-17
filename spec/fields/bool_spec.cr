require "../spec_helper"

describe Fields do
  describe "Fields::Boolean" do
    describe ".new" do
      it "create an instance of the Boolean field" do
        f = Fields::Boolean.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("Boolean")
        f.input_type.should eq("checkbox")
        f.name.should eq("")
        f.value.should be_nil
      end
    end
  end
end
