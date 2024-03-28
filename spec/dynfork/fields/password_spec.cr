require "../../spec_helper"

describe DynFork::Fields::PasswordField do
  describe ".new" do
    it "=> create instance of Password field", tags: "fields" do
      f = DynFork::Fields::PasswordField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("PasswordField")
      f.input_type.should eq("password")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_true
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength?.should eq(256_u32)
      f.minlength?.should eq(8_u32)
      f.regex?.should be_nil
      f.regex_err_msg?.should be_nil
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.empty?.should be_true
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
