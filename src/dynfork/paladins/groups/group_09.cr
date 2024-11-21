module DynFork::QPaladins::Groups
  # Create string for `SlugField`.
  # NOTE: This method is used within the `DynFork::QPaladins::Check#check` method.
  def group_09(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    result_map : Hash(String, DynFork::Globals::ResultMapType),
  ) : Nil
    #
    raw_str_arr : Array(String) = Array(String).new
    slug_sources : Array(String) = field_ptr.value.slug_sources
    {% for field in @type.instance_vars %}
      if slug_sources.includes?({{ field.name.stringify }})
        if !(value = @{{ field }}.value? || @{{ field }}.default?).nil?
            raw_str_arr << value.to_s
        else
          return if @{{ field }}.required?
          msg = "Model: `#{@@full_model_name}` > " +
                "Field: `#{field_ptr.value.name}` => " +
                "`#{@{{ field }}.name}` - " +
                "This field is specified in slug_sources. " +
                "It requires a value or default value."
          raise DynFork::Errors::Panic.new msg
        end
      end
    {% end %}
    # Insert result.
    result_map[field_ptr.value.name] = Iom::WebSlug.slug(raw_str_arr.join("-"))
  end
end
