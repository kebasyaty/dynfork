require "./root"

# Errors associated with the Model.
module Crymon::Errors::Model
  # The Model has no fields.
  class FieldsMissing < Crymon::Errors::CrymonException
    def initialize(model_name : String)
      super("Model `#{model_name}` has no fields.")
    end
  end

  # The maximum number of characters in the model name has been exceeded.
  class ModelNameExcessChars < Crymon::Errors::CrymonException
    def initialize(model_name : String)
      super("Model: `#{model_name}` => The Model name exceeds 25 characters.")
    end
  end

  # The Model name fails regular expression validation.
  class ModelNameRegexFails < Crymon::Errors::CrymonException
    def initialize(model_name : String, regex_str : String)
      super("Model: `#{model_name}` => The model name fails the regular expression test #{regex_str}")
    end
  end

  # Invalid group number.
  class InvalidGroupNumber < Crymon::Errors::CrymonException
    def initialize(model_name : String, field_name : String)
      super("Model: `#{model_name}` > Field: `#{field_name}` > Attribute: `group` => Invalid group number.")
    end
  end
end
