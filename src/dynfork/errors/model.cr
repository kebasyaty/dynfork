require "./root"

# Errors associated with the Model.
module DynFork::Errors::Model
  # The Model has no fields.
  class FieldsMissing < DynFork::Errors::DynForkException
    def initialize(model_name : String)
      super(
        "Model `#{model_name}` has no fields."
          .colorize.fore(:red).mode(:bold)
      )
    end
  end

  # The maximum number of characters in the model name has been exceeded.
  class ModelNameExcessChars < DynFork::Errors::DynForkException
    def initialize(model_name : String)
      super(
        "Model: `#{model_name}` => The Model name exceeds 25 characters."
          .colorize.fore(:red).mode(:bold)
      )
    end
  end

  # The Model name fails regular expression validation.
  class ModelNameRegexFails < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      regex_str : String
    )
      super(
        "Model: `#{model_name}` => " +
        "The model name fails the regular expression test #{regex_str}"
          .colorize.fore(:red).mode(:bold)
      )
    end
  end

  # Invalid group number.
  class InvalidGroupNumber < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      field_name : String
    )
      super(
        "Model: `#{model_name}` > Field: `#{field_name}` > Attribute: `group` => " +
        "Invalid group number."
          .colorize.fore(:red).mode(:bold)
      )
    end
  end
end
