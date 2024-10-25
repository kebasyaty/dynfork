require "../../spec_helper"

describe DynFork::Fields::ChoiceTextField do
  describe ".new" do
    it "=> create instance of ChoiceTextField", tags: "fields" do
      f = DynFork::Fields::ChoiceTextField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextField")
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
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.hint.should eq("")
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

describe DynFork::Fields::ChoiceTextMultField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultField", tags: "fields" do
      f = DynFork::Fields::ChoiceTextMultField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultField")
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
      f.choices.should eq(Array(Tuple(String, String)).new)
      f.hint.should eq("")
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

describe DynFork::Fields::ChoiceTextDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextDynField", tags: "fields" do
      f = DynFork::Fields::ChoiceTextDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextDynField")
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
      f.hint.should eq("")
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

describe DynFork::Fields::ChoiceTextMultDynField do
  describe ".new" do
    it "=> create instance of ChoiceTextMultDynField", tags: "fields" do
      f = DynFork::Fields::ChoiceTextMultDynField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ChoiceTextMultDynField")
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
      f.hint.should eq("")
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
