# Auxiliary methods for testing.
module Helper
  ALPHANUMERIC_CHARS = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  # Delete database after test.
  #
  # Example:
  # ```
  # # Delete database after test.
  # Helper.delete_test_db(database_name)
  # ```
  #
  def self.delete_test_db(database_name : String)
    database = Crymon::Globals.cache_mongo_client[database_name]
    cursor = database.list_collections("name_only": true)
    cursor.each { |collection|
      database.command(Mongo::Commands::Drop, name: collection["name"].as(Int32 | String))
    }
  end

  # Generate data for test.
  #
  # Example:
  # ```
  # # Generate data for test.
  # test_data = Helper.generate_test_data
  # unique_app_key = test_data[:unique_app_key]
  # database_name = test_data[:database_name]
  # ```
  #
  def self.generate_test_data : NamedTuple(unique_app_key: String, database_name: String)
    unique_app_key = self.generate_unique_app_key # or Random::Secure.hex(8)
    {unique_app_key: unique_app_key, database_name: "test_#{unique_app_key}"}
  end

  # Generate unique app key.
  #
  # Example:
  # ```
  # # Generate data for test.
  # unique_app_key = Helper.generate_unique_app_key
  # ```
  #
  def self.generate_unique_app_key : String
    result : String = ""
    # Shuffle symbols in random order.
    shuffled_chars : Array(String) = ALPHANUMERIC_CHARS.split("").shuffle
    #
    chars_count : Int32 = shuffled_chars.size - 1
    size : Int32 = 16
    size.times do
      result += shuffled_chars[Random.rand(chars_count)]
    end
    result
  end
end
