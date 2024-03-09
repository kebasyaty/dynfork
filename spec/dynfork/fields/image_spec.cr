require "../../spec_helper"

describe DynFork::Fields::ImageField do
  describe ".new" do
    it "=> create instance of Image field", tags: "fields" do
      f = DynFork::Fields::ImageField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ImageField")
      f.input_type.should eq("file")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.media_root.should eq("assets/media")
      f.media_url.should eq("/media")
      f.target_dir.should eq("images")
      f.accept.should eq("image/png,image/jpeg,image/webp")
      f.thumbnails?.should be_nil
      f.maxsize.should eq(2097152_i64)
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.hint.should eq("Only jpg/jpeg, png and webp files are allowed.")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(5_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
