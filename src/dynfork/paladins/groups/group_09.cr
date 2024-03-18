module DynFork::Paladins::Groups
  # Create string for SlugField.
  def group_09(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    result_bson_ptr : Pointer(BSON)
  )
    slug : String = ""
    {% for field in @type.instance_vars %}
      if @{{ field }}.slug_sources.includes?({{ field.name.stringify }})
        if value = @{{ field }}.value || @{{ field }}.default
          slug += value.to_s
        end
      end
    {% end %}
    # Insert result.
    result_bson_ptr.value[field_ptr.value.name] = slug
  end
end
