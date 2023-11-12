require "../../spec_helper"

describe Crymon::Globals do
  describe "settings" do
    it "=> checking crymon global settings without database name", tags: "global_settings" do
      Crymon::Globals.cache_app_name = "AppName"
      Crymon::Globals.cache_unique_app_key = "RT0839370A074kVh"
      #
      Crymon::Globals::ValidationCacheSettings.validation
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("RT0839370A074kVh")
      Crymon::Globals.cache_database_name.should eq("AppName_RT0839370A074kVh")
    end

    it "=> checking crymon global settings with database name", tags: "global_settings" do
      Crymon::Globals.cache_app_name = "AppName"
      Crymon::Globals.cache_unique_app_key = "RT0839370A074kVh"
      Crymon::Globals.cache_database_name = "DatabaseName360"
      #
      Crymon::Globals::ValidationCacheSettings.validation
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("RT0839370A074kVh")
      Crymon::Globals.cache_database_name.should eq("DatabaseName360")
    end
  end

  describe "cache_app_name" do
    it "=> number of characters exceeded", tags: "global_settings" do
      ex = expect_raises(Crymon::Errors::CacheSettingsExcessChars) do
        Crymon::Globals.cache_app_name = "Lorem ipsum dolor sit amet consectetur adipis"
        Crymon::Globals::ValidationCacheSettings.validation
      end
      ex.message.should eq(
        %(Global settings > Parameter: "cache_app_name" => The line size of 44 characters has been exceeded.)
      )
    end
  end
end
