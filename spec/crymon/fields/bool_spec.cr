require "../../spec_helper"

describe Crymon::Fields::BoolField do
  describe ".new" do
    it "=> create instance of Boolean field", tags: "fields" do
      f = Crymon::Fields::BoolField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("BoolField")
      f.input_type.should eq("checkbox")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(13_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
