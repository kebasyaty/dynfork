require "../../spec_helper"

describe DynFork::Fields::SlugField do
  describe ".new" do
    it "=> create instance of Slug field", tags: "fields" do
      f = DynFork::Fields::SlugField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("SlugField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_true
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_true
      f.ignored?.should be_false
      f.slug_sources.should eq(["hash"])
      f.hint.should eq(Array(String).new)
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(9_u8)
    end
  end
end
