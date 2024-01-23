require "./root"

# Errors associated with the caching.
module Crymon::Errors::Cache
  # The allowed number of characters in global settings has been exceeded.
  class SettingsExcessChars < Crymon::Errors::CrymonException
    def initialize(
      parameter_name : String,
      limit_size : UInt32
    )
      super(
        "Global settings > Parameter: `#{parameter_name}` => " +
        "The line size of #{limit_size} characters has been exceeded."
      )
    end
  end

  # The global settings fails regular expression validation.
  class SettingsRegexFails < Crymon::Errors::CrymonException
    def initialize(
      parameter_name : String,
      regex_str : String
    )
      super(
        "Global settings > Parameter: `#{parameter_name}` => " +
        "Regular expression check fails: #{regex_str}."
      )
    end
  end
end
