require "../spec_helper"

describe Fields do
  describe "Fields::ChoiceF64Field" do
    describe ".new" do
      it "create an instance of the ChoiceF64Field" do
        f = Fields::ChoiceF64Field.new
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
        f.group.should eq(4_u32)
      end
    end
  end

  describe "Fields::ChoiceF64MultField" do
    describe ".new" do
      it "create an instance of the ChoiceF64MultField" do
        f = Fields::ChoiceF64MultField.new
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
        f.group.should eq(6_u32)
      end
    end
  end

  describe "Fields::ChoiceF64DynField" do
    describe ".new" do
      it "create an instance of the ChoiceF64DynField" do
        f = Fields::ChoiceF64DynField.new
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
        f.group.should eq(5_u32)
      end
    end
  end

  describe "Fields::ChoiceF64MultDynField" do
    describe ".new" do
      it "create an instance of the ChoiceF64MultDynField" do
        f = Fields::ChoiceF64MultDynField.new
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
        f.group.should eq(7_u32)
      end
    end
  end
end
