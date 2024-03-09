require "../../spec_helper"

describe Spec::Data::FilledModel do
  describe "#to_json" do
    it "=> create json from structure", tags: "model_json" do
      f = Spec::Data::FilledModel.new
      j : String = f.to_json
      j.empty?.should be_false
    end
  end
  describe "#from_json" do
    it "=> create instance from json", tags: "model_json" do
      f = Spec::Data::FilledModel.new
      j : String = f.to_json
      f = Spec::Data::FilledModel.from_json(j)
      # TextField
      f.first_name.id.should eq("FilledModel--first-name")
      f.first_name.label.should eq("")
      f.first_name.field_type.should eq("TextField")
      f.first_name.input_type.should eq("text")
      f.first_name.name.should eq("first_name")
      f.first_name.value?.should be_nil
      f.first_name.default.should eq("Cat")
      f.first_name.placeholder.should eq("")
      f.first_name.textarea?.should be_false
      f.first_name.disabled?.should be_false
      f.first_name.readonly?.should be_false
      f.first_name.hide?.should be_false
      f.first_name.required?.should be_false
      f.first_name.unique?.should be_false
      f.first_name.maxlength.should eq(256)
      f.first_name.minlength.should eq(0)
      f.first_name.regex?.should be_nil
      f.first_name.regex_err_msg?.should be_nil
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
      # I64Field
      f.age.id.should eq("FilledModel--age")
      f.age.label.should eq("")
      f.age.field_type.should eq("I64Field")
      f.age.input_type.should eq("number") # number | range
      f.age.name.should eq("age")
      f.age.value?.should be_nil
      f.age.default.should eq(0_i64)
      f.age.placeholder.should eq("")
      f.age.disabled?.should be_false
      f.age.readonly?.should be_false
      f.age.hide?.should be_false
      f.age.required?.should be_false
      f.age.unique?.should be_false
      f.age.max.should eq(Int64::MAX)
      f.age.min.should eq(0_i64)
      f.age.step.should eq(1_i64)
      f.age.hint.should eq("")
      f.age.warning.should eq("")
      f.age.errors.should eq(Array(String).new)
      f.age.group.should eq(6_u8)
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
      f.birthday.value?.should be_nil
      f.birthday.default.should eq("23.12.2023")
      f.birthday.placeholder.should eq("")
      f.birthday.disabled?.should be_false
      f.birthday.readonly?.should be_false
      f.birthday.hide?.should be_false
      f.birthday.required?.should be_false
      f.birthday.unique?.should be_false
      f.birthday.max?.should be_nil
      f.birthday.min?.should be_nil
      f.birthday.hint.should eq("Formats: dd-mm-yyyy | dd/mm/yyyy | dd.mm.yyyy | yyyy-mm-dd | yyyy/mm/dd | yyyy.mm.dd")
      f.birthday.warning.should eq("")
      f.birthday.errors.should eq(Array(String).new)
      f.birthday.group.should eq(2_u8)
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
