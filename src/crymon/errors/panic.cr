require "./root"

# Exception types.
module Crymon::Errors
  # A type of global exception that should not be raised in production.
  class Panic < Crymon::Errors::Root::CrymonException
    def initialize(message : String)
      super
    end
  end
end
