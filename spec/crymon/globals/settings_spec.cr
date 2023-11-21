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
        "Global settings > Parameter: cache_app_name => The line size of 44 characters has been exceeded."
      )
    end

    it "=> not matching regular expression", tags: "global_settings" do
      ex = expect_raises(Crymon::Errors::CacheSettingsRegexFails) do
        Crymon::Globals.cache_app_name = "Lorem ipsum dolor sit amet consectetur adipi"
        Crymon::Globals::ValidationCacheSettings.validation
      end
      ex.message.should eq(
        "Global settings > Parameter: cache_app_name => Regular expression check fails: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/."
      )
      # Reset the state to working.
      Crymon::Globals.cache_app_name = "AppName"
    end
  end

  # To generate a key (This is not an advertisement): https://randompasswordgen.com/
  describe "cache_unique_app_key" do
    it "=> number of characters exceeded", tags: "global_settings" do
      ex = expect_raises(Crymon::Errors::CacheSettingsExcessChars) do
        Crymon::Globals.cache_unique_app_key = "g80K2R476Y46428cM"
        Crymon::Globals::ValidationCacheSettings.validation
      end
      ex.message.should eq(
        "Global settings > Parameter: cache_unique_app_key => The line size of 16 characters has been exceeded."
      )
    end

    it "=> not matching regular expression", tags: "global_settings" do
      ex = expect_raises(Crymon::Errors::CacheSettingsRegexFails) do
        Crymon::Globals.cache_unique_app_key = "!Q2)x7d_P#4G}Bb/"
        Crymon::Globals::ValidationCacheSettings.validation
      end
      ex.message.should eq(
        "Global settings > Parameter: cache_unique_app_key => Regular expression check fails: /^[a-zA-Z0-9]{16}$/."
      )
      # Reset the state to working.
      Crymon::Globals.cache_unique_app_key = "RT0839370A074kVh"
    end
  end

  describe "cache_database_name" do
    it "=> number of characters exceeded", tags: "global_settings" do
      ex = expect_raises(Crymon::Errors::CacheSettingsExcessChars) do
        Crymon::Globals.cache_database_name = "LoremIpsumDolorSitAmetConsecteturAdipiscingElitIntegerLacinia"
        Crymon::Globals::ValidationCacheSettings.validation
      end
      ex.message.should eq(
        "Global settings > Parameter: cache_database_name => The line size of 60 characters has been exceeded."
      )
      # Reset the state to working.
      Crymon::Globals.cache_database_name = "DatabaseName360"
    end
  end
end
