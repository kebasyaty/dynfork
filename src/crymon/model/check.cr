# Validation of Model data before saving to the database.
module Crymon::Check
  # Output data for the Save method.
  struct OutputData
    getter data : BSON
    getter is_valid : Bool

    def initialize(@data : BSON, @is_valid : Bool); end
  end

  # Check data validity.
  # NOTE: The main use is to check data from web forms.
  def is_valid : Bool
    self.check(true).is_valid
  end

  # Validation of Model data.
  # NOTE: only_validation = true - No accumulation of errors.
  private def check(only_validation : Bool = false) : OutputData
    # Get model key.
    model_key : String = self.model_key
    # Does the document exist in the database?
    is_updated : Bool = !@hash.value.nil?
    # Is there any incorrect data?
    is_error_symptom : Bool = false
    # Errors from additional validation of fields.
    error_map : Hash(String, String) = self.add_validation
    unless error_map.empty?
      is_error_symptom = true
    end
    # Data to save or update to the database.
    db_data_bson : BSON = BSON.new

    # Start checking all fields.
    {% for var in @type.instance_vars %}
      (err_msg : String? = error_map[{{ var.name.stringify }}]?
        errors_accumulation(err_msg.to_s) unless err_msg.nil?)
      #
      next if @{{ var }}.is_ignored
      #
      case @{{ var }}.group
      when 1
        # "ColorField" | "EmailField" | "PasswordField" | "PhoneField"
        # | "TextField" | "HashField" | "URLField" | "IPField"
        #
      else
        nil
      end
    {% end %}
    #
    # --------------------------------------------------------------------------
    OutputData.new(db_data_bson, !is_error_symptom)
  end
end
