require "../spec_helper"

describe Fields do
  describe "Fields::ChoiceI64Field" do
    describe ".new" do
      it "create instance of ChoiceI64Field" do
        f = Fields::ChoiceI64Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceI64Field")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.is_multiple.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.choices.should eq(Array(Tuple(Int64, String)).new)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(4_u8)
      end
    end
  end

  describe "Fields::ChoiceI64MultField" do
    describe ".new" do
      it "create instance of ChoiceI64MultField" do
        f = Fields::ChoiceI64MultField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceI64MultField")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.is_multiple.should be_true
        f.is_required.should be_false
        f.is_unique.should be_false
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.choices.should eq(Array(Tuple(Int64, String)).new)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(6_u8)
      end
    end
  end

  describe "Fields::ChoiceI64DynField" do
    describe ".new" do
      it "create instance of ChoiceI64DynField" do
        f = Fields::ChoiceI64DynField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceI64DynField")
        f.name.should eq("")
        f.value.should be_nil
        f.is_multiple.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.choices.should eq(Array(Tuple(Int64, String)).new)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(5_u8)
      end
    end
  end

  describe "Fields::ChoiceI64MultDynField" do
    describe ".new" do
      it "create instance of ChoiceI64MultDynField" do
        f = Fields::ChoiceI64MultDynField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceI64MultDynField")
        f.name.should eq("")
        f.value.should be_nil
        f.is_multiple.should be_true
        f.is_required.should be_false
        f.is_unique.should be_false
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.choices.should eq(Array(Tuple(Int64, String)).new)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(7_u8)
      end
    end
  end
end
