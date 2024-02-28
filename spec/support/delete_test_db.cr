module Spec::Support
  # Delete database (before|after) test.
  #
  # Example:
  # ```
  # # Data for test.
  # # To generate a key (This is not an advertisement): https://randompasswordgen.com/
  # unique_app_key = "jeKZ9lIGL9aLRvlz"
  # database_name = "test_#{unique_app_key}"
  # database = DynFork::Globals.cache_mongo_client[database_name]
  # # Delete the database for the test.
  # Spec::Support.delete_test_db(database)
  # ```
  #
  def self.delete_test_db(database : Mongo::Database)
    cursor = database.list_collections("name_only": true)
    cursor.each { |collection|
      database.command(Mongo::Commands::Drop, name: collection["name"].as(Int32 | String))
    }
  end
end
