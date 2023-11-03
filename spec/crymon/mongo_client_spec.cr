require "../spec_helper"

describe Crymon do
  describe "Cryomongo" do
    it "=> initialize mongodb client" do
      # Create a Mongo client, using a standard mongodb connection string.
      client : Mongo::Client = Mongo::Client.new # defaults to: "mongodb://localhost:27017"
      # The overwhelming majority of programs should use a single client and should not bother with closing clients.
      # Otherwise, to free the underlying resources a client must be manually closed.
      client.close
    end
  end
end
