require "../../spec_helper"

describe Crymon::Globals::ImageData do
  describe ".new" do
    it "=> create an instance of the ImageData", tags: "fields" do
      f = Crymon::Globals::ImageData.new
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
      f.delete?.should be_false
    end
  end
end

describe Crymon::Fields::ImageField do
  describe ".new" do
    it "=> create instance of Image field", tags: "fields" do
      f = Crymon::Fields::ImageField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ImageField")
      f.input_type.should eq("file")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should be_nil
      f.placeholder.should eq("")
      f.media_root.should eq("assets/media")
      f.media_url.should eq("/media")
      f.target_dir.should eq("images")
      f.accept.should eq("image/png, image/jpeg, image/webp")
      f.thumbnails.should eq(Array({String, UInt32}).new)
      f.quality?.should be_true
      f.maxsize.should eq(2.0_f32)
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.hint.should eq("Only jpg/jpeg, png and webp files are allowed.")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(9_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
