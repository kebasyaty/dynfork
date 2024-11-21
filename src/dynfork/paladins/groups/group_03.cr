module DynFork::QPaladins::Groups
  # Validation of `choice` type fields:
  # <br>
  # _ChoiceTextField | ChoiceTextMultField
  # | ChoiceTextDynField | ChoiceTextMultDynField
  # | ChoiceI64Field | ChoiceI64MultField
  # | ChoiceI64DynField | ChoiceI64MultDynField
  # | ChoiceF64Field | ChoiceF64MultField
  # | ChoiceF64DynField | ChoiceF64MultDynField_
  # NOTE: This method is used within the `DynFork::QPaladins::Check#check` method.
  def group_03(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_map : Hash(String, DynFork::Globals::ResultMapType),
    collection_ptr : Pointer(Mongo::Collection),
  ) : Nil
    # Get current value.
    current_value : DynFork::Globals::FieldValueTypes = (
      value : DynFork::Globals::FieldValueTypes = field_ptr.value.value? || field_ptr.value.default?
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil?
        if field_ptr.value.required?
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            error_symptom_ptr?
          )
        end
        (result_map[field_ptr.value.name] = nil) if save?
        return
      end
      value
    )
    # Does the field value match the possible options in choices.
    unless field_ptr.value.has_value?
      self.accumulate_error(
        I18n.t(:value_does_not_match),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Insert result.
    (result_map[field_ptr.value.name] = current_value) if save?
  end
end
