require "../spec_helper"

describe Crymon::Fields::FileData do
  describe ".new" do
    it "=> create instance of FileData" do
      f = Crymon::Fields::FileData.new
      f.path.should eq("")
      f.url.should eq("")
      f.name.should eq("")
      f.size.should eq(0_f64)
      f.is_delete.should be_false
    end
  end
end

describe Crymon::Fields::FileField do
  describe ".new" do
    it "=> create instance of  File field" do
      f = Crymon::Fields::FileField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("FileField")
      f.input_type.should eq("file")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("")
      f.media_root.should eq("../assets/media")
      f.media_url.should eq("/media")
      f.target_dir.should eq("files")
      f.accept.should eq("")
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(8_u8)
      f["default"]?.should be_true
    end
  end
end
