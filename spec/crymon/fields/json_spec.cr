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
      f.first_name.id.should eq("FilledModel--first-name")
      f.first_name.label.should eq("")
      f.first_name.field_type.should eq("TextField")
      f.first_name.input_type.should eq("text")
      f.first_name.name.should eq("first_name")
      f.first_name.value.should be_nil
      f.first_name.default.should eq("Cat")
      f.first_name.placeholder.should eq("")
      f.first_name.is_textarea.should be_false
      f.first_name.is_disabled.should be_false
      f.first_name.is_readonly.should be_false
      f.first_name.is_hide.should be_false
      f.first_name.is_required.should be_false
      f.first_name.is_unique.should be_false
      f.first_name.maxlength.should eq(256)
      f.first_name.minlength.should eq(0)
      f.first_name.other_attrs.should eq("")
      f.first_name.css_classes.should eq("")
      f.first_name.hint.should eq("")
      f.first_name.warning.should eq("")
      f.first_name.errors.should eq(Array(String).new)
      f.first_name.group.should eq(1_u8)
      f["first_name"]?.should be_true
      f["age"]?.should be_true
      f["birthday"]?.should be_true
      f["hash"]?.should be_true
      f["created_at"]?.should be_true
      f["updated_at"]?.should be_true
      f["???"]?.should be_false
      #
      # U32Field
      f.age.id.should eq("FilledModel--age")
      f.age.label.should eq("")
      f.age.field_type.should eq("U32Field")
      f.age.input_type.should eq("number") # number | range
      f.age.name.should eq("age")
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
      f["first_name"]?.should be_true
      f["age"]?.should be_true
      f["birthday"]?.should be_true
      f["hash"]?.should be_true
      f["created_at"]?.should be_true
      f["updated_at"]?.should be_true
      f["???"]?.should be_false
      #
      # DateField
      f.birthday.id.should eq("FilledModel--birthday")
      f.birthday.label.should eq("")
      f.birthday.field_type.should eq("DateField")
      f.birthday.input_type.should eq("date")
      f.birthday.name.should eq("birthday")
      f.birthday.value.should be_nil
      f.birthday.default.should eq("0000-00-00")
      f.birthday.placeholder.should eq("")
      f.birthday.is_disabled.should be_false
      f.birthday.is_readonly.should be_false
      f.birthday.is_hide.should be_false
      f.birthday.is_required.should be_false
      f.birthday.is_unique.should be_false
      f.birthday.max.should eq("")
      f.birthday.min.should eq("")
      f.birthday.other_attrs.should eq("")
      f.birthday.css_classes.should eq("")
      f.birthday.hint.should eq("Format: yyyy-mm-dd")
      f.birthday.warning.should eq("")
      f.birthday.errors.should eq(Array(String).new)
      f.birthday.group.should eq(3_u8)
      f["first_name"]?.should be_true
      f["age"]?.should be_true
      f["birthday"]?.should be_true
      f["hash"]?.should be_true
      f["created_at"]?.should be_true
      f["updated_at"]?.should be_true
      f["???"]?.should be_false
    end
  end
end
