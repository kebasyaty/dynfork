# Validation of Model data before saving to the database.
module Crymon::Check
  # Validation of Model data.
  def check
    # Get model key.
    model_key : String = self.model_key
    # Does the document exist in the database?
    is_updated : Bool = !@hash.value.empty?
    # Is there any incorrect data?
    is_error_symptom : Bool = false
  end
end
