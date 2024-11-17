module Spec::Support
  # Delete database (before|after) test.
  #
  # Example:
  # ```
  # # To generate a key (This is not an advertisement): https://randompasswordgen.com/
  # unique_key = "jeKZ9lIGL9aLRvlz"
  # database_name = "test_#{unique_key}"
  # mongo_uri = "mongodb://localhost:27017"
  # mongo_client = Mongo::Client.new(mongo_uri)
  # database = Mongo::Client.new(mongo_uri)[database_name])
  # Spec::Support.delete_test_db(database)
  # mongo_client.close
  # ```
  #
  def self.delete_test_db(database : Mongo::Database)
    cursor = database.list_collections("name_only": true)
    cursor.each { |collection|
      database.command(Mongo::Commands::Drop, name: collection["name"].as(Int32 | String))
    }
  end
end
