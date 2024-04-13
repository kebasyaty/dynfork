# require "../../../../../spec_helper"

# describe DynFork::Model do
#   describe ".find_many_to_json" do
#     it "=> from empty collection", tags: "find_many" do
#       # Init data for test.
#       #
#       # To generate a key (This is not an advertisement): https://randompasswordgen.com/
#       unique_app_key = "23316i6H423N69L3"
#       database_name = "test_#{unique_app_key}"
#       mongo_uri = "mongodb://localhost:27017"

#       # Delete database before test.
#       # (if the test fails)
#       Spec::Support.delete_test_db(
#         Mongo::Client.new(mongo_uri)[database_name])

#       # Run migration.
#       DynFork::Migration::Monitor.new(
#         "app_name": "AppName",
#         "unique_app_key": unique_app_key,
#         "database_name": database_name,
#         "mongo_uri": mongo_uri,
#         "model_list": {
#           Spec::Data::FullDefault,
#         }
#       ).migrat
#       #
#       # HELLISH BURN
#       # ------------------------------------------------------------------------
#       json : String = Spec::Data::FullDefault.find_many_to_json
#       json.empty?.should be_true
#       # ------------------------------------------------------------------------
#       #
#       # Delete database after test.
#       Spec::Support.delete_test_db(
#         DynFork::Globals.cache_mongo_database)
#       #
#       DynFork::Globals.cache_mongo_client.close
#     end
#   end
# end
