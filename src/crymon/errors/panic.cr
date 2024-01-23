require "./root"

# Errors associated with panic.
module Crymon::Errors::Panic
  class Panic < Crymon::Errors::Root::CrymonException
    def initialize(message : String)
      super
    end
  end
end
