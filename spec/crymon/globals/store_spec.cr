require "../../spec_helper"

describe Crymon::Globals do
  describe "store" do
    it "=> store_metadata", tags: "globals_store" do
      # ...
    end

    it "=> validation store_settings", tags: "globals_store" do
      Crymon::Globals.store_settings = Crymon::Globals::StoreSettings.new(
        "app_name": "AppName",
        "unique_app_key": "RT0839370A074kVh",
        "database_name": "DatabaseName360",
      )
    end
  end
end
