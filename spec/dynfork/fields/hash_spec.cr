require "../../spec_helper"

describe DynFork::Fields::HashField do
  describe ".new" do
    it "=> create instance of Hash field", tags: "fields" do
      f = DynFork::Fields::HashField.new
      f.id.should eq("")
      f.label.should eq("Document ID")
      f.field_type.should eq("HashField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("Enter document ID")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength.should eq(24)
      f.minlength.should eq(24)
      f.hint.should eq("For enter a document ID.")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.alerts.should eq(Array(String).new)
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
      f.object_id.should be_nil
    end
  end
end
