require "../../spec_helper"

describe DynFork::Fields::PhoneField do
  describe ".new" do
    it "=> create instance of Phone field", tags: "fields" do
      f = DynFork::Fields::PhoneField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("PhoneField")
      f.input_type.should eq("tel")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength?.should be_nil
      f.minlength?.should be_nil
      f.regex.should eq("^[+]?[0-9]{8,15}$")
      f.regex_err_msg.should eq("Invalid Phone number !")
      f.hint.should eq("Format: +xxxxxxxx... or xxxxxxxx...")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
    end
  end
end
