require "../spec_helper"

describe Crymon do
  describe "Crymon::Fields::HashField" do
    describe ".new" do
      it "create instance of Hash field" do
        f = Crymon::Fields::HashField.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("HashField")
        f.input_type.should eq("text")
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_true
        f.is_required.should be_false
        f.is_unique.should be_false
        f.maxlength.should eq(12)
        f.minlength.should eq(12)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(1_u8)
      end
    end
  end
end
