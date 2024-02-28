require "./root"

# Errors associated with the date and time.
module DynFork::Errors::Date
  # Invalid date.
  class InvalidDate < DynFork::Errors::CrymonException
    def initialize
      super(I18n.t(:invalid_date))
    end
  end

  # Invalid date and time.
  class InvalidDateTime < DynFork::Errors::CrymonException
    def initialize
      super(I18n.t(:invalid_datetime))
    end
  end
end
