require "../../spec_helper"

describe DynFork::Fields::IPField do
  describe ".new" do
    it "=> create instance of URL field", tags: "fields" do
      f = DynFork::Fields::IPField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("IPField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength.should eq(2083)
      f.minlength.should eq(0)
      f.hint.should eq("")
      f.warning.should eq(Array(String).new)
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
    end
  end
end
