require "../../spec_helper"

describe Crymon::Fields::TextField do
  describe ".to_json" do
    it "=> create json from structure" do
      f = Crymon::Fields::TextField.new
      j : String = f.to_json
      j.empty?.should be_false
    end
  end
  describe ".from_json" do
    it "=> create instance from json" do
      f = Crymon::Fields::TextField.new
      j : String = f.to_json
      f = Crymon::Fields::TextField.from_json(j)
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
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end

describe Helper::FilledModel do
  describe ".to_json" do
    it "=> create json from structure" do
      f = Helper::FilledModel.new
      j : String = f.to_json
      j.empty?.should be_false
    end
  end
  describe ".from_json" do
    it "=> create instance from json" do
      f = Helper::FilledModel.new
      j : String = f.to_json
      f = Helper::FilledModel.from_json(j)
      # TextField
      f.name.id.should eq("")
      f.name.label.should eq("")
      f.name.field_type.should eq("TextField")
      f.name.input_type.should eq("text")
      f.name.name.should eq("")
      f.name.value.should be_nil
      f.name.default.should eq("Cat")
      f.name.placeholder.should eq("")
      f.name.is_textarea.should be_false
      f.name.is_disabled.should be_false
      f.name.is_readonly.should be_false
      f.name.is_hide.should be_false
      f.name.is_required.should be_false
      f.name.is_unique.should be_false
      f.name.maxlength.should eq(256)
      f.name.minlength.should eq(0)
      f.name.other_attrs.should eq("")
      f.name.css_classes.should eq("")
      f.name.hint.should eq("")
      f.name.warning.should eq("")
      f.name.errors.should eq(Array(String).new)
      f.name.group.should eq(1_u8)
      f["name"]?.should be_true
      f["no_var"]?.should be_false
      #
      # U32Field
      f.age.id.should eq("")
      f.age.label.should eq("")
      f.age.field_type.should eq("U32Field")
      f.age.input_type.should eq("number") # number | range
      f.age.name.should eq("")
      f.age.value.should be_nil
      f.age.default.should eq(0_u32)
      f.age.placeholder.should eq("")
      f.age.is_disabled.should be_false
      f.age.is_readonly.should be_false
      f.age.is_hide.should be_false
      f.age.is_required.should be_false
      f.age.is_unique.should be_false
      f.age.max.should eq(UInt32::MAX)
      f.age.min.should eq(0_u32)
      f.age.step.should eq(1_u32)
      f.age.other_attrs.should eq("")
      f.age.css_classes.should eq("")
      f.age.hint.should eq("")
      f.age.warning.should eq("")
      f.age.errors.should eq(Array(String).new)
      f.age.group.should eq(11_u8)
      f["age"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
