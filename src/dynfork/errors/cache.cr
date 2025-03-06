require "./root"

# Errors associated with the caching.
module DynFork::Errors::Cache
  # The global settings fails regular expression validation.
  class RegexFails < DynFork::Errors::DynForkException
    def initialize(
      parameter_name : String,
      regex_str : String,
    )
      super(
        "DynFork::Globals > Parameter: `#{parameter_name}` => " +
        "Regular expression check fails: #{regex_str}."
      )
    end
  end
end
