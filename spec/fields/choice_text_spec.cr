require "../spec_helper"

describe Crymon::Fields::ChoiceTextField do
  describe ".new" do
    it "=> create instance of ChoiceTextField" do
      f = Crymon::Fields::ChoiceTextField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(4_u8)
    end
  end
end

describe Crymon::Fields::ChoiceTextMultField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultField" do
      f = Crymon::Fields::ChoiceTextMultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(6_u8)
    end
  end
end

describe Crymon::Fields::ChoiceTextDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextDynField" do
      f = Crymon::Fields::ChoiceTextDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.is_multiple.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(5_u8)
    end
  end
end

describe Crymon::Fields::ChoiceTextMultDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultDynField" do
      f = Crymon::Fields::ChoiceTextMultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.is_multiple.should be_true
      f.is_required.should be_false
      f.is_unique.should be_false
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(7_u8)
    end
  end
end
