require "./root"

# Exceptions for situations that should not occur.
module Crymon::Errors::Panic
  # Exception for situation that should not occur.
  class Panic < Crymon::Errors::Root::CrymonException
    def initialize(message : String)
      super
    end
  end
end
