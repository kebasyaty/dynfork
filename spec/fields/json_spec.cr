require "../spec_helper"

describe Fields do
  describe "Fields::TextField" do
    describe ".to_json" do
      it "create json from structure" do
        f = Fields::TextField.new
        j : String = f.to_json
        j.empty?.should be_false
      end
    end
    describe ".from_json" do
      it "create an instance from json" do
        f = Fields::TextField.new
        j : String = f.to_json
        f = Fields::TextField.from_json(j)
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("TextField")
        f.input_type.should eq("text")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_textarea.should be_false
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.maxlength.should eq(256)
        f.minlength.should eq(0)
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
