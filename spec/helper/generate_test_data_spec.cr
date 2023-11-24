require "../spec_helper"

describe "Generate test data" do
  it "=> get test data", tags: "get_test_data" do
    test_data = Helper.generate_test_data
    puts %(unique_app_key = "#{test_data[:unique_app_key]}")
    puts %(database_name = "#{test_data[:database_name]}")
  end
end
