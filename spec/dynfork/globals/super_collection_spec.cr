require "../../spec_helper"

describe DynFork::Globals do
  it "=> super_collection_name - check original value", tags: "global_super_collection" do
    DynFork::Globals.super_collection_name.should eq("SUPER_COLLECTION")
  end
end
