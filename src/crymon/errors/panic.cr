require "./root"

# Global exception types for situations that should not occur.
module Crymon::Errors
  # A global exception type for situations that should not occur.
  class Panic < Crymon::Errors::Root::CrymonException
    def initialize(message : String)
      super
    end
  end
end
