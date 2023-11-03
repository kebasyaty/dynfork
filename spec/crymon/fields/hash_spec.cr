require "../../spec_helper"

describe Crymon::Fields::HashField do
  describe ".new" do
    it "=> create instance of Hash field" do
      f = Crymon::Fields::HashField.new
      f.id.should eq("")
      f.label.should eq("Hash ID")
      f.field_type.should eq("HashField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("Enter the Document ID for MongoDB")
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_true
      f.is_required.should be_false
      f.is_unique.should be_true
      f.maxlength.should eq(24)
      f.minlength.should eq(24)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("For enter a document ID")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
