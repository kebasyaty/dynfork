require "../spec_helper"

describe Crymon::Fields::ChoiceF64Field do
  describe ".new" do
    it "=> create instance of ChoiceF64Field" do
      f = Crymon::Fields::ChoiceF64Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64Field")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(4_u8)
    end
  end
end

describe Crymon::Fields::ChoiceF64MultField do
  describe ".new" do
    it "=> create instance of ChoiceF64MultField" do
      f = Crymon::Fields::ChoiceF64MultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64MultField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(6_u8)
    end
  end
end

describe Crymon::Fields::ChoiceF64DynField do
  describe ".new" do
    it "=> create instance of ChoiceF64DynField" do
      f = Crymon::Fields::ChoiceF64DynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64DynField")
      f.name.should eq("")
      f.value.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(5_u8)
    end
  end
end

describe Crymon::Fields::ChoiceF64MultDynField do
  describe ".new" do
    it "=> create instance of ChoiceF64MultDynField" do
      f = Crymon::Fields::ChoiceF64MultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64MultDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(7_u8)
    end
  end
end
