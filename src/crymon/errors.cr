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

    # Error: Missing parameter for Metadata.
    class ParameterMissing < CrymonException
      def initialize(parameter_name : String)
        super(%(Missing "#{parameter_name}" parameter for Meta.))
      end
    end

    # Error: The Model has no fields.
    class FieldsMissing < CrymonException
      def initialize(model_name : String)
        super(%(Model "#{model_name}" has no fields.))
      end
    end

    # Error: The names in the list of ignored fields do not match.
    class IgnoredFieldMissing < CrymonException
      def initialize(field_name : String)
        super(%(The "#{field_name}" field is missing from the list of ignored fields.))
      end
    end

    # Error: Invalid type.
    class InvalidType < CrymonException
      def initialize(message : String)
        super
      end
    end
  end
end
