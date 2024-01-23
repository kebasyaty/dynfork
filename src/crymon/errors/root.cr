# A set of custom exceptions for Crymon.
module Crymon::Errors
  # Root custom exception.
  class CrymonException < Exception; end

  # A type of global exception that should not be raised in production.
  class Panic < Crymon::Errors::CrymonException
    def initialize(message : String)
      super
    end
  end
end
