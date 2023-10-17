require "../spec_helper"

describe Fields do
  describe "Fields::Boolean" do
    describe ".new" do
      it "create an instance of the Boolean field" do
        f = Fields::Boolean.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("Boolean")
        f.input_type.should eq("checkbox")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_false
        f.placeholder.should eq("")
        f.disabled.should be_false
        f.readonly.should be_false
        f.is_hide.should be_false
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(13_u32)
      end
    end
  end
end
