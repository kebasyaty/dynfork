require "../../spec_helper"

describe DynFork::Fields::BoolField do
  describe ".new" do
    it "=> create instance of Boolean field", tags: "fields" do
      f = DynFork::Fields::BoolField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("BoolField")
      f.input_type.should eq("checkbox")
      f.name.should eq("")
      f.value?.should be_nil
      f.default.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(8_u8)
    end
  end
end
