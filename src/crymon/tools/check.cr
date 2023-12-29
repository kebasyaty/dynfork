# External tools for Model validation.
module Crymon::Tools::Check
  # Output data type for the `Model.check()` method.
  struct OutputData
    getter data : BSON
    getter is_valid : Bool

    def initialize(@data : BSON, @is_valid : Bool); end
  end
end
