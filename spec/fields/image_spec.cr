require "../spec_helper"

describe Crymon::Fields::ImageData do
  describe ".new" do
    it "=> create an instance of the ImageData" do
      f = Crymon::Fields::ImageData.new
      f.path.should eq("")
      f.path_xs.should eq("")
      f.path_sm.should eq("")
      f.path_md.should eq("")
      f.path_lg.should eq("")
      f.url.should eq("")
      f.url_xs.should eq("")
      f.url_sm.should eq("")
      f.url_md.should eq("")
      f.url_lg.should eq("")
      f.name.should eq("")
      f.size.should eq(0_f64)
      f.width.should eq(0_f64)
      f.height.should eq(0_f64)
      f.is_delete.should be_false
    end
  end
end

describe Crymon::Fields::ImageField do
  describe ".new" do
    it "=> create instance of Image field" do
      f = Crymon::Fields::ImageField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ImageField")
      f.input_type.should eq("file")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("")
      f.media_root.should eq("../../assets/media")
      f.media_url.should eq("/media")
      f.target_dir.should eq("images")
      f.accept.should eq("")
      f.thumbnails.should eq(Array({String, UInt32}).new)
      f.is_quality.should be_true
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
      f.group.should eq(9_u8)
      f["default"]?.should be_true
    end
  end
end
