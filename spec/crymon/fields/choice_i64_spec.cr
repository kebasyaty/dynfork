require "../../spec_helper"

describe Crymon::Fields::ChoiceI64Field do
  describe ".new" do
    it "=> create instance of ChoiceI64Field", tags: "fields" do
      f = Crymon::Fields::ChoiceI64Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceI64Field")
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
      f.choices.should eq(Array(Tuple(Int64, String)).new)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(4_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceI64MultField do
  describe ".new" do
    it "=> create instance of ChoiceI64MultField", tags: "fields" do
      f = Crymon::Fields::ChoiceI64MultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceI64MultField")
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
      f.choices.should eq(Array(Tuple(Int64, String)).new)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(6_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceI64DynField do
  describe ".new" do
    it "=> create instance of ChoiceI64DynField", tags: "fields" do
      f = Crymon::Fields::ChoiceI64DynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceI64DynField")
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
      f.group.should eq(5_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Crymon::Fields::ChoiceI64MultDynField do
  describe ".new" do
    it "=> create instance of ChoiceI64MultDynField", tags: "fields" do
      f = Crymon::Fields::ChoiceI64MultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceI64MultDynField")
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
      f.group.should eq(7_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
