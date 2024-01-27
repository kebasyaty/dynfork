require "./root"

# Errors associated with the fields.
module Crymon::Errors::Fields
  # If slug source does not match field of Model.
  class SlugSourceInvalid < Crymon::Errors::CrymonException
    def initialize(
      model_name : String,
      field_name : String,
      source_name : String
    )
      super(
        "Model: `#{model_name}` > Field: `#{field_name}` > " +
        "Attribute: `slug_sources` => Incorrect source `#{source_name}`."
      )
    end
  end

  # Invalid field type for slug source.
  class SlugSourceTypeInvalid < Crymon::Errors::CrymonException
    def initialize(
      model_name : String,
      slug_field : String,
      source_field : String
    )
      super(
        "Model: `#{model_name}` > Slug Field: `#{slug_field}` > " +
        "Source Field: `#{source_field}` => " +
        "Invalid field type for slug source."
      )
    end
  end

  # Invalid input type.
  class InvalidInputType < Crymon::Errors::CrymonException
    def initialize(input_type : String)
      super("The `#{input_type}` invalid input type.")
    end
  end
end
