require "./root"

# Errors associated with the date and time.
module Crymon::Errors::Date
  # Invalid date.
  class InvalidDate < Crymon::Errors::CrymonException
    def initialize
      super(I18n.t(:invalid_date))
    end
  end

  # Invalid date and time.
  class InvalidDateTime < Crymon::Errors::CrymonException
    def initialize
      super(I18n.t(:invalid_datetime))
    end
  end
end
