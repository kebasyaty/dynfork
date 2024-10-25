require "../../spec_helper"

describe DynFork::Fields::ChoiceF64Field do
  describe ".new" do
    it "=> create instance of ChoiceF64Field", tags: "fields" do
      f = DynFork::Fields::ChoiceF64Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64Field")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.multiple?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.hint.should eq(Array(String).new)
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      # nodoc
      f.max?.should be_nil
      f.min?.should be_nil
      f.regex?.should be_nil
      f.regex_err_msg?.should be_nil
      f.maxlength?.should be_nil
      f.minlength?.should be_nil
      f.maxsize.should eq(0_f32)
      f.unique?.should be_false
      f.input_type?.should be_nil
      f.media_root.should eq("")
      f.media_url.should eq("")
      f.target_dir.should eq("")
      f.thumbnails?.should be_nil
      f.use_editor?.should be_false
    end
  end
end

describe DynFork::Fields::ChoiceF64MultField do
  describe ".new" do
    it "=> create instance of ChoiceF64MultField", tags: "fields" do
      f = DynFork::Fields::ChoiceF64MultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64MultField")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.multiple?.should be_true
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices.should eq(Array(Tuple(Float64, String)).new)
      f.hint.should eq(Array(String).new)
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      # nodoc
      f.max?.should be_nil
      f.min?.should be_nil
      f.regex?.should be_nil
      f.regex_err_msg?.should be_nil
      f.maxlength?.should be_nil
      f.minlength?.should be_nil
      f.maxsize.should eq(0_f32)
      f.unique?.should be_false
      f.input_type?.should be_nil
      f.media_root.should eq("")
      f.media_url.should eq("")
      f.target_dir.should eq("")
      f.thumbnails?.should be_nil
      f.use_editor?.should be_false
    end
  end
end

describe DynFork::Fields::ChoiceF64DynField do
  describe ".new" do
    it "=> create instance of ChoiceF64DynField", tags: "fields" do
      f = DynFork::Fields::ChoiceF64DynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64DynField")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.multiple?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices?.should be_nil
      f.hint.should eq(Array(String).new)
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      # nodoc
      f.max?.should be_nil
      f.min?.should be_nil
      f.regex?.should be_nil
      f.regex_err_msg?.should be_nil
      f.maxlength?.should be_nil
      f.minlength?.should be_nil
      f.maxsize.should eq(0_f32)
      f.unique?.should be_false
      f.input_type?.should be_nil
      f.media_root.should eq("")
      f.media_url.should eq("")
      f.target_dir.should eq("")
      f.thumbnails?.should be_nil
      f.use_editor?.should be_false
    end
  end
end

describe DynFork::Fields::ChoiceF64MultDynField do
  describe ".new" do
    it "=> create instance of ChoiceF64MultDynField", tags: "fields" do
      f = DynFork::Fields::ChoiceF64MultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceF64MultDynField")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.multiple?.should be_true
      f.required?.should be_false
      f.unique?.should be_false
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.ignored?.should be_false
      f.choices?.should be_nil
      f.hint.should eq(Array(String).new)
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(3_u8)
      # nodoc
      f.max?.should be_nil
      f.min?.should be_nil
      f.regex?.should be_nil
      f.regex_err_msg?.should be_nil
      f.maxlength?.should be_nil
      f.minlength?.should be_nil
      f.maxsize.should eq(0_f32)
      f.unique?.should be_false
      f.input_type?.should be_nil
      f.media_root.should eq("")
      f.media_url.should eq("")
      f.target_dir.should eq("")
      f.thumbnails?.should be_nil
      f.use_editor?.should be_false
    end
  end
end
