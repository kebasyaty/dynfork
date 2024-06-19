require "./root"

# Errors associated with the password.
module DynFork::Errors::Password
  # Invalid type.
  class OldPassNotMatch < DynFork::Errors::DynForkException
    def initialize
      super(I18n.t(:old_pass_not_match))
    end
  end
end
