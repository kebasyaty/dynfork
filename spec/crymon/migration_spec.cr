require "../spec_helper"

describe Crymon::Migration::Monitor do
  describe ".new" do
    it "=> create instance without database name", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "mongo_uri": "mongodb://localhost:27017"
      )
      #
      m.app_name.should eq("AppName")
      m.unique_app_key.should eq("0w7n5731X13s1641")
      m.database_name.should eq("")
      m.mongo_uri.should eq("mongodb://localhost:27017")
    end

    it "=> create instance with database name", tags: "migration" do
      m = Crymon::Migration::Monitor.new(
        "app_name": "AppName",
        "unique_app_key": "0w7n5731X13s1641",
        "database_name": "DatabaseName360",
        "mongo_uri": "mongodb://localhost:27017"
      )
      m.app_name.should eq("AppName")
      m.unique_app_key.should eq("0w7n5731X13s1641")
      m.database_name.should eq("DatabaseName360")
      m.mongo_uri.should eq("mongodb://localhost:27017")
    end
  end
end
