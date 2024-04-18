module DynFork::Paladins::Groups
  # Validation of `date` type fields:
  # <br>
  # _"DateField" | "DateTimeField"_
  def group_02(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_map_ptr : Pointer(Hash(String, DynFork::Globals::ResultMapType)),
    collection_ptr : Pointer(Mongo::Collection)
  ) : Void
    # Get from cache Time objects - Max, min and default.
    time_objects : NamedTuple(
      default: Time?,
      max: Time?,
      min: Time?) = @@meta.not_nil![:time_object_list][field_ptr.value.name]
    # Get current value.
    current_value : Time = (
      value : DynFork::Globals::ValueTypes | Time = field_ptr.value.value? || field_ptr.value.default?
      # Validation, if the field is required and empty, accumulate the error.
      # ( The default value is used whenever possible )
      if value.nil? || value.to_s.empty?
        if field_ptr.value.required?
          self.accumulate_error(
            I18n.t(:required_field),
            field_ptr,
            error_symptom_ptr?
          )
        end
        (result_map_ptr.value[field_ptr.value.name] = nil) if save?
        return
      end
      #
      if !(value = field_ptr.value.value?).nil?
        err_msg = nil
        case field_ptr.value.field_type
        when "DateField"
          begin
            value = self.date_parse(value.to_s)
          rescue ex
            err_msg = ex.message
          end
        when "DateTimeField"
          begin
            value = self.datetime_parse(value.to_s)
          rescue ex
            err_msg = ex.message
          end
        end
        unless err_msg.nil?
          self.accumulate_error(
            err_msg,
            field_ptr,
            error_symptom_ptr?
          )
          return
        end
      else
        value = time_objects[:default]
      end
      value.as(Time)
    )
    # Validation the `max` field attribute.
    unless (max : Time? = time_objects[:max]).nil?
      if (current_value <=> max.not_nil!) == 1
        err_msg = I18n.t(
          "date_not_greater_max.interpolation",
          curr_date: field_ptr.value.value? || field_ptr.value.default?,
          max_date: field_ptr.value.max?
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `min` field attribute.
    unless (min : Time? = time_objects[:min]).nil?
      if (current_value <=> min.not_nil!) == 1
        err_msg = I18n.t(
          "data_not_less_min.interpolation",
          curr_date: field_ptr.value.value? || field_ptr.value.default?,
          min_date: field_ptr.value.min?
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Insert result.
    (result_map_ptr.value[field_ptr.value.name] = current_value) if save?
  end
end
