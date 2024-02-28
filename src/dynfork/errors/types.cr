require "./root"

# Errors associated with the data types.
module DynFork::Errors::Types
  # Invalid type.
  class InvalidType < DynFork::Errors::CrymonException
    def initialize(message : String)
      super
    end
  end
end
