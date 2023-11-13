require "../spec_helper"

describe Crymon::Migration::Monitor do
  describe ".new" do
    it "=> create instance without database name", tags: "migration" do
      Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017"
      )
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("0w7n5731X13s1641")
      Crymon::Globals.cache_database_name.should eq("AppName_0w7n5731X13s1641")
    end

    it "=> create instance with database name", tags: "migration" do
      Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0585I0S5huR5r08q",
        "database_name": "DatabaseName360",
        "mongo_uri": "mongodb://localhost:27017"
      )
      #
      Crymon::Globals.cache_app_name.should eq("AppName")
      Crymon::Globals.cache_unique_app_key.should eq("0585I0S5huR5r08q")
      Crymon::Globals.cache_database_name.should eq("DatabaseName360")
    end
  end

  describe ".refresh" do
    it "=> create instance and run refresh method", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "070kI4s05i8F8uep",
        "mongo_uri": "mongodb://localhost:27017"
      )
      m.refresh.should be_nil
    end
  end
end
