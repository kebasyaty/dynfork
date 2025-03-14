require "../../spec_helper"

describe DynFork::Fields::TextField do
  describe ".to_json" do
    it "=> create json from structure", tags: "field_json" do
      f = DynFork::Fields::TextField.new
      j : String = f.to_json
      j.empty?.should be_false
    end
  end
  describe ".from_json" do
    it "=> create instance from json", tags: "field_json" do
      f = DynFork::Fields::TextField.new
      j : String = f.to_json
      f = DynFork::Fields::TextField.from_json(j)
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("TextField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.textarea?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength.should eq(256)
      f.minlength.should eq(0)
      f.hint.should eq("")
      f.warning.should eq(Array(String).new)
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
    end
  end
end
