require "../../spec_helper"

describe Crymon::Fields::ChoiceTextField do
  describe ".new" do
    it "=> create instance of ChoiceTextField", tags: "fields" do
      f = Crymon::Fields::ChoiceTextField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.multiple?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceTextMultField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultField", tags: "fields" do
      f = Crymon::Fields::ChoiceTextMultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.multiple?.should be_true
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceTextDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextDynField", tags: "fields" do
      f = Crymon::Fields::ChoiceTextDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.multiple?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should be_nil
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceTextMultDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultDynField", tags: "fields" do
      f = Crymon::Fields::ChoiceTextMultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultDynField")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.multiple?.should be_true
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should be_nil
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
