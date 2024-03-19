module DynFork::Paladins::Groups
  # Create string for SlugField.
  def group_09(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    result_bson_ptr : Pointer(BSON)
  )
    raw_str : String = ""
    {% for field in @type.instance_vars %}
      if @{{ field }}.slug_sources.includes?({{ field.name.stringify }})
        if value = @{{ field }}.value || @{{ field }}.default
          raw_str += value.to_s
        end
      end
    {% end %}
    # Insert result.
    result_bson_ptr.value[field_ptr.value.name] = Iom::WebSlug.slug(raw_str)
  end
end
