require "./root"

# Errors associated with the fields.
module DynFork::Errors::Fields
  # If the slug source does not match any field name in the Model.
  class SlugSourceNameInvalid < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      field_name : String,
      source_name : String
    )
      super(
        "Model: `#{model_name}` > Field: `#{field_name}` > " +
        "Attribute: `slug_sources` => The `#{source_name}` field missing in Model."
      )
    end
  end

  # Invalid field type for slug source.
  class SlugSourceTypeInvalid < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      slug_field : String,
      source_field : String
    )
      super(
        "Model: `#{model_name}` > Slug Field: `#{slug_field}` > " +
        "Attribute: `slug_sources` > Source Field: `#{source_field}` => " +
        "Invalid field type for slug source." +
        "Allowed field types: HashField, TextField, EmailField, " +
        "DateField, DateTimeField, I64Field, F64Field."
      )
    end
  end

  # For slug sources, all fields except the `hash` field must be required.
  class SlugSourceNotRequired < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      slug_field : String,
      source_field : String
    )
      super(
        "Model: `#{model_name}` > Slug Field: `#{slug_field}` > " +
        "Attribute: `slug_sources` > Source Field: `#{source_field}` => " +
        "For slug sources, all fields except the `hash` field must be required."
      )
    end
  end

  # If the slug source does not have unique fields.
  class SlugSourceNotUnique < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      slug_field : String
    )
      super(
        "Model: `#{model_name}` > Slug Field: `#{slug_field}` > " +
        "Attribute: `slug_sources` => " +
        "Does not have a single unique field."
      )
    end
  end

  # If the max date is not greater than the min date.
  class NotCorrectMinDate < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      field_name : String
    )
      super(
        "Model: `#{model_name}` > Field: `#{field_name}` > " +
        "The max date must be greater than the min date."
      )
    end
  end

  # If the default date does not match the minimum or maximum value.
  class NotCorrectDefaultDate < DynFork::Errors::DynForkException
    def initialize(
      model_name : String,
      field_name : String,
      msg_err : String
    )
      super("Model: `#{model_name}` > Field: `#{field_name}` > #{msg_err}")
    end
  end

  # Invalid input type.
  class InvalidInputType < DynFork::Errors::DynForkException
    def initialize(input_type : String)
      super("The `#{input_type}` invalid input type.")
    end
  end
end
