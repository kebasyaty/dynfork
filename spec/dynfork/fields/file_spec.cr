require "../../spec_helper"

describe DynFork::Fields::FileField do
  describe ".new" do
    it "=> create instance of  File field", tags: "fields" do
      f = DynFork::Fields::FileField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("FileField")
      f.input_type.should eq("file")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.media_root.should eq("public/media/uploads")
      f.media_url.should eq("/media/uploads")
      f.target_dir.should eq("files")
      f.accept.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.maxsize.should eq(2097152_i64)
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.hint.should eq("")
      f.warning.should eq(Array(String).new)
      f.errors.should eq(Array(String).new)
      f.group.should eq(4_u8)
    end
  end
end
