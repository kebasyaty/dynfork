module DynFork::Paladins::Groups
  # Create string for SlugField.
  def group_09(
    field_ptr : Pointer(DynFork::Globals::FieldTypes),
    result_map_ptr : Pointer(Hash(String, DynFork::Globals::ResultMapType))
  )
    raw_str : String = ""
    slug_sources : Array(String) = field_ptr.value.slug_sources
    {% for field in @type.instance_vars %}
      if slug_sources.includes?({{ field.name.stringify }})
        if value = @{{ field }}.value? || @{{ field }}.default?
          if !raw_str.empty?
            raw_str += "-#{value}"
          else
            raw_str += value.to_s
          end
        end
      end
    {% end %}
    # Insert result.
    result_map_ptr.value[field_ptr.value.name] = Iom::WebSlug.slug(raw_str)
  end
end
