# Custom exceptions for Cryod.
module Cryod
  # Root custom exception.
  class CryodException < Exception; end

  # Error: Invalid input type.
  class InvalidInputType < CryodException
    def initialize(input_type : String)
      super(%(The "#{input_type}" invalid input type.))
    end
  end
end
