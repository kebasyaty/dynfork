require "./root"

# Errors associated with the password.
module DynFork::Errors::Password
  # Invalid type.
  class OldPassNotMatch < DynFork::Errors::DynForkException
    def initialize(message : String)
      super
    end
  end
end
