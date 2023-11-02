require "../spec_helper"

describe Crymon do
  describe "Cryomongo" do
    it "=> initialize mongodb client" do
      # Create a Mongo client, using a standard mongodb connection string.
      client = Mongo::Client.new # defaults to: "mongodb://localhost:27017"
    end
  end
end
