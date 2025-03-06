module DynFork::QPaladins::Groups
  # Validation of `text` type fields:
  # <br>
  # _ColorField | EmailField | PasswordField | PhoneField
  # | TextField | HashField | URLField | IPField_
  # NOTE: This method is used within the `DynFork::QPaladins::Check#check` method.
  def group_01(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    error_symptom_ptr? : Pointer(Bool),
    update? : Bool,
    save? : Bool,
    result_map : Hash(String, DynFork::Globals::ResultMapType),
    collection_ptr : Pointer(Mongo::Collection),
    id_ptr : Pointer(BSON::ObjectId?),
  ) : Nil
    # When updating, we skip field password type.
    if update? && field_ptr.value.field_type == "PasswordField"
      field_ptr.value.value = nil
      return
    end
    # Get current value.
    current_value : String = (
      value : DynFork::Globals::FieldValueTypes = field_ptr.value.value? || field_ptr.value.default?
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
        (result_map[field_ptr.value.name] = nil) if save?
        return
      end
      value.to_s
    )
    # Validation the `regex` field attribute.
    unless (pattern = field_ptr.value.regex?).nil?
      unless /#{pattern}/.matches?(current_value)
        self.accumulate_error(
          field_ptr.value.regex_err_msg.to_s,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `maxlength` field attribute.
    unless (maxlength = field_ptr.value.maxlength?).nil?
      if current_value.size > maxlength.to_i32
        err_msg = I18n.t(
          "number_not_greater_max.interpolation",
          curr_num: current_value.size,
          max_num: maxlength
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `minlength` field attribute.
    unless (minlength = field_ptr.value.minlength?).nil?
      if current_value.size < minlength.to_i32
        err_msg = I18n.t(
          "number_not_less_min.interpolation",
          curr_num: current_value.size,
          min_num: minlength
        )
        self.accumulate_error(
          err_msg,
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Validation the `unique` field attribute.
    if field_ptr.value.unique? && field_ptr.value.field_type != "PasswordField" &&
       !self.check_uniqueness?(current_value, collection_ptr, field_ptr, id_ptr)
      self.accumulate_error(
        I18n.t(:not_unique),
        field_ptr,
        error_symptom_ptr?
      )
    end
    # Validation Email, Url, IP, Color, Passwor, Phone.
    case field_ptr.value.field_type
    when "EmailField"
      unless Valid.email? current_value
        self.accumulate_error(
          I18n.t(:invalid_email),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "URLField"
      unless Valid.url? current_value
        self.accumulate_error(
          I18n.t(:invalid_url),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "IPField"
      unless Valid.ip? current_value
        self.accumulate_error(
          I18n.t(:invalid_ip),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "ColorField"
      unless Valid.color_code? current_value
        self.accumulate_error(
          I18n.t(:invalid_color_code),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "PasswordField"
      unless Valid.password? current_value
        self.accumulate_error(
          I18n.t(
            "allowed_chars.interpolation",
            chars: %(a-z A-Z 0-9 - . _ ! " ` ' # % & , : ; < > = @ { } ~ $ \( \) * + / \\ ? [ ] ^ |)
          ),
          field_ptr,
          error_symptom_ptr?
        )
      end
    when "PhoneField"
      if field_ptr.value.regex?.presence.nil? && !Valid.phone_number? current_value
        self.accumulate_error(
          I18n.t(:invalid_phone),
          field_ptr,
          error_symptom_ptr?
        )
      end
    end
    # Insert result.
    if save?
      if field_ptr.value.field_type == "PasswordField"
        current_value = Crypto::Bcrypt::Password.create(current_value).to_s
      end
      result_map[field_ptr.value.name] = current_value
    end
  end
end
