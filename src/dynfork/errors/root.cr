# A set of custom exceptions for DynFork.
module DynFork::Errors
  # Root custom exception.
  class CrymonException < Exception; end

  # A type of global exception that should not be raised in production.
  class Panic < DynFork::Errors::CrymonException
    def initialize(message : String)
      super
    end
  end
end
