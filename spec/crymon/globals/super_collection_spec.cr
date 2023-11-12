require "../../spec_helper"

describe Crymon::Globals do
  it "=> cache_super_collection_name - check original value", tags: "global_super_collection" do
    Crymon::Globals.cache_super_collection_name.should eq("SUPER_COLLECTION")
  end
end
