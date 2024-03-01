require "../../spec_helper"

describe DynFork::Globals do
  describe "FileData" do
    describe ".new" do
      it "=> create instance", tags: "global_types" do
        t = DynFork::Globals::FileData.new
        #
        t.path.should eq("")
        t.url.should eq("")
        t.name.should eq("")
        t.size.should eq(0_i64)
        t.delete?.should be_false
        t.extension.should be_nil
        t.tempfile.should be_nil
      end
    end
  end

  describe "ImageData" do
    describe ".new" do
      it "=> create instance", tags: "global_types" do
        t = DynFork::Globals::ImageData.new
        #
        t.path.should eq("")
        t.path_xs.should eq("")
        t.path_sm.should eq("")
        t.path_md.should eq("")
        t.path_lg.should eq("")
        #
        t.url.should eq("")
        t.url_xs.should eq("")
        t.url_sm.should eq("")
        t.url_md.should eq("")
        t.url_lg.should eq("")
        #
        t.name.should eq("")
        t.width.should eq(0_i32)
        t.height.should eq(0_i32)
        t.size.should eq(0_i64)
        t.delete?.should be_false
        t.extension.should be_nil
        t.tempfile.should be_nil
        t.target_dir.should be_nil
      end
    end
  end
end
