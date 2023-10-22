require "../spec_helper"

describe Fields do
  describe "Fields::ChoiceU32Field" do
    describe ".new" do
      it "create instance of ChoiceU32Field" do
        f = Fields::ChoiceU32Field.new
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
        f.group.should eq(4_u32)
      end
    end
  end

  describe "Fields::ChoiceU32MultField" do
    describe ".new" do
      it "create instance of ChoiceU32MultField" do
        f = Fields::ChoiceU32MultField.new
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
        f.group.should eq(6_u32)
      end
    end
  end

  describe "Fields::ChoiceU32DynField" do
    describe ".new" do
      it "create instance of ChoiceU32DynField" do
        f = Fields::ChoiceU32DynField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceU32DynField")
        f.name.should eq("")
        f.value.should be_nil
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
        f.group.should eq(5_u32)
      end
    end
  end

  describe "Fields::ChoiceU32MultDynField" do
    describe ".new" do
      it "create instance of ChoiceU32MultDynField" do
        f = Fields::ChoiceU32MultDynField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceU32MultDynField")
        f.name.should eq("")
        f.value.should be_nil
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
        f.group.should eq(7_u32)
      end
    end
  end
end
