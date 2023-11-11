require "../../spec_helper"

describe Crymon::Globals do
  describe "store" do
    it "=> checking crymon global settings without database name" do
      Crymon::Globals.store_app_name = "AppName"
      Crymon::Globals.store_unique_app_key = "RT0839370A074kVh"
      #
      Crymon::Globals::ValidationStoreSettings.validation
      #
      Crymon::Globals.store_app_name.should eq("AppName")
      Crymon::Globals.store_unique_app_key.should eq("RT0839370A074kVh")
      Crymon::Globals.store_database_name.should eq("AppName_RT0839370A074kVh")
    end

    it "=> checking crymon global settings with database name", tags: "globals_store" do
      Crymon::Globals.store_app_name = "AppName"
      Crymon::Globals.store_unique_app_key = "RT0839370A074kVh"
      Crymon::Globals.store_database_name = "DatabaseName360"
      #
      Crymon::Globals::ValidationStoreSettings.validation
      #
      Crymon::Globals.store_app_name.should eq("AppName")
      Crymon::Globals.store_unique_app_key.should eq("RT0839370A074kVh")
      Crymon::Globals.store_database_name.should eq("DatabaseName360")
    end
  end
end
