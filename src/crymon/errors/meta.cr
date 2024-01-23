require "./root"

# Errors associated with the metadata.
module Crymon::Errors::Meta
  # Missing parameter for Metadata.
  class ParameterMissing < Crymon::Errors::Root::CrymonException
    def initialize(model_name : String, parameter_name : String)
      super("Model: `#{model_name}` => Missing `#{parameter_name}` parameter for Meta.")
    end
  end

  # The allowed number of characters in the metadata parameters has been exceeded.
  class ParamExcessChars < Crymon::Errors::Root::CrymonException
    def initialize(model_name : String, parameter_name : String, limit_size : UInt32)
      super("Model: `#{model_name}` > Meta parameter: `#{parameter_name}` => The line size of #{limit_size} characters has been exceeded.")
    end
  end

  # The metadata parameter fails regular expression validation.
  class ParamRegexFails < Crymon::Errors::Root::CrymonException
    def initialize(model_name : String, parameter_name : String, regex_str : String)
      super("Model: `#{model_name}` > Meta parameter: `#{parameter_name}` => Regular expression check fails: #{regex_str}.")
    end
  end
end
