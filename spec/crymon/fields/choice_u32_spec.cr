require "../../spec_helper"

describe Crymon::Fields::ChoiceU32Field do
  describe ".new" do
    it "=> create instance of ChoiceU32Field", tags: "fields" do
      f = Crymon::Fields::ChoiceU32Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceU32Field")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(UInt32, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(4_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceU32MultField do
  describe ".new" do
    it "=> create instance of ChoiceU32MultField", tags: "fields" do
      f = Crymon::Fields::ChoiceU32MultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceU32MultField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(UInt32, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(6_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceU32DynField do
  describe ".new" do
    it "=> create instance of ChoiceU32DynField", tags: "fields" do
      f = Crymon::Fields::ChoiceU32DynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceU32DynField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(UInt32, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(5_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceU32MultDynField do
  describe ".new" do
    it "=> create instance of ChoiceU32MultDynField", tags: "fields" do
      f = Crymon::Fields::ChoiceU32MultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceU32MultDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(UInt32, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(7_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
