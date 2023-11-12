require "../../spec_helper"

describe Crymon::Globals do
  it "=> cache_metadata - type checking", tags: "global_other_vars" do
    Crymon::Globals.cache_metadata.should eq(
      Hash(String, Crymon::Globals::CacheMetaDataType).new
    )
  end
end
