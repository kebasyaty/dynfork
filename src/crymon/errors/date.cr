require "./root"

# Errors associated with the date and time.
module Crymon::Errors::Date
  # Invalid date.
  class InvalidDate < Crymon::Errors::Root::CrymonException
    def initialize
      super("Invalid date.")
    end
  end

  # Invalid date and time.
  class InvalidDateTime < Crymon::Errors::Root::CrymonException
    def initialize
      super("Invalid date and time.")
    end
  end
end
