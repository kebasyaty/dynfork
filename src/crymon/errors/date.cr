# ???
module Crymon::Errors::Date
  # Invalid date.
  class InvalidDate < Crymon::Errors::CrymonException
    def initialize
      super("Invalid date.")
    end
  end

  # Invalid date and time.
  class InvalidDateTime < Crymon::Errors::CrymonException
    def initialize
      super("Invalid date and time.")
    end
  end
end
