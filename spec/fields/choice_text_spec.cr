require "../spec_helper"

describe Fields do
  describe "Fields::ChoiceTextField" do
    describe ".new" do
      it "create an instance of the ChoiceText field" do
        f = Fields::ChoiceTextField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ChoiceTextField")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
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
        f.group.should eq(4_u32)
      end
    end
  end
end
