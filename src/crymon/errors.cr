# Custom exceptions for Crymon.
module Crymon
  # Root custom exception.
  class CrymonException < Exception; end

  # Error: Invalid input type.
  class InvalidInputType < CrymonException
    def initialize(input_type : String)
      super(%(The "#{input_type}" invalid input type.))
    end
  end
end
