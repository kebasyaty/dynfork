require "../spec_helper"

describe Crymon::Fields::PhoneField do
  describe ".new" do
    it "=> create instance of Phone field" do
      f = Crymon::Fields::PhoneField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("PhoneField")
      f.input_type.should eq("tel")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("")
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.maxlength.should eq(15)
      f.minlength.should eq(8)
      f.regex.should eq("^+?[0-9]{8,15}$")
      f.regex_err_msg.should eq("Invalid Phone number.")
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("Format: +xxxxxxxx... or xxxxxxxx...")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
      f["default"]?.should be_true
    end
  end
end
