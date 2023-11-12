require "../../spec_helper"

describe Crymon::Globals do
  it "=> cache_metadata - check original value", tags: "global_other_vars" do
    Crymon::Globals.cache_metadata.should eq(
      Hash(String, Crymon::Globals::CacheMetaDataType).new
    )
  end

  it "=> cache_mongo_client - check original value", tags: "global_other_vars" do
    Crymon::Globals.cache_mongo_client.should eq(Mongo::Client.new)
  end

  it "=> cache_super_collection_name - check original value", tags: "global_other_vars" do
    Crymon::Globals.cache_super_collection_name.should eq("SUPER_COLLECTION")
  end
end
