# Auxiliary tools for testing.
module Crymon::TestingTools
  extend self

  # Delete database after test.
  #
  # Example:
  # ```
  # # Delete database after test.
  # Crymon::TestingTools.delete_test_db(database_name)
  # ```
  #
  def delete_test_db(database_name : String)
    database = Crymon::Globals.cache_mongo_client[database_name]
    cursor = database.list_collections("name_only": true)
    cursor.each { |collection|
      database.command(Mongo::Commands::Drop, name: collection["name"].as(Int32 | String))
    }
  end
end
