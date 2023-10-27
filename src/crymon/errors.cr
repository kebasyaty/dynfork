# Custom exceptions for Crymon.
module Crymon
  module Errors
    # Root custom exception.
    class CrymonException < Exception; end

    # Error: Invalid input type.
    class InvalidInputType < CrymonException
      def initialize(input_type : String)
        super(%(The "#{input_type}" invalid input type.))
      end
    end

    # Error: Missing parameter.
    class MissingParameter < CrymonException
      def initialize(parameter_name : String)
        super(%(Missing "#{parameter_name}" parameter for Metadata.))
      end
    end
  end
end
