module Crymon
  # Methods for additional actions and additional validation.
  abstract struct Addition < Crymon::Hooks
    # It is intended for additional actions with fields.
    # WARNING: This method is execute first.
    def add_actions; end

    # It is supposed to be use to additional validation of fields.
    # WARNING: This method is execute second.
    def add_validation : Hash(String, String)
      # _**Format:** <"field_name", "Error message">_
      error_map = Hash(String, String).new
      error_map
    end
  end
end
