require "../spec_helper"

describe Fields do
  describe "Fields::SlugField" do
    describe ".new" do
      it "create an instance of the Slug field" do
        f = Fields::SlugField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("SlugField")
        f.input_type.should eq("text")
        f.name.should eq("")
        f.value.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_true
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_true
        f.slug_sources.should eq(["hash"])
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(2_u32)
      end
    end
  end
end
