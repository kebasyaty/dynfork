module DynFork::Paladins::Groups
  # Validation of `date` type fields:
  # <br>
  # "DateField" | "DateTimeField"
  def group_02(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    save? : Bool,
    result_bson_ptr : Pointer(BSON),
    collection_ptr : Pointer(Mongo::Collection)
  )
    # Get from cache Time objects - Max, min and default.
    time_objects : NamedTuple(
      default: Time?,
      max: Time?,
      min: Time?) = @@meta.not_nil![:time_object_list][field_ptr.value.name]
    # Get current value.
    current_value : Time = (
      value : DynFork::Globals::ValueTypes | Time = field_ptr.value.value || field_ptr.value.default
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
        (result_bson_ptr.value[field_ptr.value.name] = nil) if save?
        return
      end
      #
      if value = field_ptr.value.value
        err_msg : String? = nil
        case field_ptr.value.field_type
        when "DateField"
          begin
            value = self.date_parse(field_ptr.value.value.to_s)
          rescue ex
            err_msg = ex.message
          end
        when "DateTimeField"
          begin
            value = self.datetime_parse(field_ptr.value.value.to_s)
          rescue ex
            err_msg = ex.message
          end
        end
        unless err_msg.nil?
          self.accumulate_error(
            err_msg.not_nil!,
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
    if max = time_objects[:max]
      if (current_value <=> max) == 1
        err_msg = I18n.t(
          "date_not_greater_max.interpolation",
          curr_date: field_ptr.value.value || field_ptr.value.default,
          max_date: field_ptr.value.max
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `min` field attribute.
    if min = time_objects[:min]
      if (current_value <=> min) == 1
        err_msg = I18n.t(
          "data_not_less_min.interpolation",
          curr_date: field_ptr.value.value || field_ptr.value.default,
          min_date: field_ptr.value.min
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `unique` field attribute.
    if field_ptr.value.unique? &&
       !collection_ptr.value.find_one({field_ptr.value.name => current_value}).nil?
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Insert result.
    (result_bson_ptr.value[field_ptr.value.name] = current_value) if save?
  end
end
