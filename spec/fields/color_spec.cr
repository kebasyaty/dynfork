require "../spec_helper"

describe Fields do
  describe "Fields::ColorField" do
    describe ".new" do
      it "create an instance of the Color field" do
        f = Fields::ColorField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("ColorField")
        f.input_type.should eq("text")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should eq("#000000")
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.minlength.should eq(0)
        f.maxlength.should eq(256)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(1_u32)
      end
    end
  end
end
