# Auxiliary methods for testing.
module Crymon::Tools::Test
  # Delete database (before|after) test.
  #
  # Example:
  # ```
  # Crymon::Tools::Test.delete_test_db(database_name)
  # ```
  #
  def self.delete_test_db(database_name : String)
    database = Crymon::Globals.cache_mongo_client[database_name]
    cursor = database.list_collections("name_only": true)
    cursor.each { |collection|
      database.command(Mongo::Commands::Drop, name: collection["name"].as(Int32 | String))
    }
  end
end
