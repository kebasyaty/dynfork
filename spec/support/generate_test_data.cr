module Spec::Support
  # Generate data for test.
  #
  # Example:
  # ```
  # # Generate data for test.
  # test_data = Spec::Support.generate_test_data
  # unique_app_key = test_data[:unique_app_key]
  # database_name = test_data[:database_name]
  # ```
  #
  def self.generate_test_data : NamedTuple(unique_app_key: String, database_name: String)
    unique_app_key = self.generate_unique_app_key # or Random::Secure.hex(8)
    {unique_app_key: unique_app_key, database_name: "test_#{unique_app_key}"}
  end
end
