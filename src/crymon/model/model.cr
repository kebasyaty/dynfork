require "json"
require "./implement/impl"

module Crymon
  # Abstraction for converting Crystal structures into Crymon Models.
  #
  # Simple example:
  # ```
  # @[Crymon::Meta(service_name: "Accounts")]
  # struct User < Crymon::Model
  #   getter username = Crymon::Fields::TextField.new
  #   getter birthday = Crymon::Fields::DateField.new
  # end
  # ```
  #
  # Extended Example:
  # ```
  # @[Crymon::Meta(
  #   service_name: "Accounts",
  #   is_del_doc: false
  # )]
  # struct User < Crymon::Model
  #   getter username = Crymon::Fields::TextField.new(
  #     "label": "Username",
  #     "maxlength": 150,
  #     "minlength": 1,
  #     "regex": "^[a-zA-Z0-9_@.+]$",
  #     "regex_err_msg": "Allowed chars: a-z A-Z 0-9 _ @ . +",
  #     "is_required": true,
  #     "is_unique": true
  #   )
  #   getter email = Crymon::Fields::EmailField.new(
  #     "label": "E-mail",
  #     "maxlength": 320,
  #     "is_required": true,
  #     "is_unique": true
  #   )
  #   getter birthday = Crymon::Fields::DateField.new(
  #     "label": "Birthday",
  #   )
  #   getter slug = Crymon::Fields::SlugField.new(
  #     "label": "Slug",
  #     "slug_sources": ["hash", "username"]
  #   )
  #   getter password = Crymon::Fields::PasswordField.new(
  #     "label": "Password",
  #   )
  #   # Do not save the value of this field to the database.
  #   # This field is for verification purposes only.
  #   getter confirm_password = Crymon::Fields::PasswordField.new(
  #     "label": "Confirm password",
  #     "is_ignored": true
  #   )
  #   getter is_active: Crymon::Fields::BoolField.new(
  #     "label": "is active?",
  #     "default": true
  #   )
  # end
  # ```
  #
  abstract struct Model < Crymon::Implement
    include JSON::Serializable
    include JSON::Serializable::Strict
    include Crymon::Caching

    getter hash = Crymon::Fields::HashField.new
    getter created_at = Crymon::Fields::DateTimeField
      .new("label": "Created at", "is_hide": true)
    getter updated_at = Crymon::Fields::DateTimeField
      .new("label": "Updated at", "is_hide": true)

    def initialize
      model_key : String = self.model_key
      self.caching(model_key) if Crymon::Globals.cache_metadata[model_key]?.nil?
      self.inject(model_key)
    end

    # Injecting metadata from storage in Model.
    def inject(model_key : String)
      metadata : Crymon::Globals::CacheMetaDataType = Crymon::Globals.cache_metadata[model_key]
      var_name : String = ""
      json : String?
      # Add the values of the attributes **id** and **name** from the cache to the Model.
      {% for var in @type.instance_vars %}
        var_name = {{ var.name.stringify }}
        field_attrs = metadata[:field_attrs][var_name]
        @{{ var }}.id = field_attrs[:id]
        @{{ var }}.name = field_attrs[:name]
        # Add dynamic field data from the cache to the Model.
        if json = metadata[:data_dynamic_fields][var_name]?
          @{{ var }}.set_choices(json)
        end
      {% end %}
    end

    # Get model key.
    # NOTE: To access data in the cache.
    def model_key : String
      model_name : String = {{ @type.name.stringify }}.split("::").last
      service_name : String = {{ @type.annotation(Crymon::Meta)[:service_name] }} ||
        raise Crymon::Errors::MetaParameterMissing.new(model_name, "service_name")
      "#{service_name}_#{model_name}"
    end

    # Determine the presence of a variable (field) in the model.
    def []?(variable) : Bool
      {% for var in @type.instance_vars %}
        if {{ var.name.stringify }} == variable
          return true
        end
      {% end %}
      false
    end
  end
end
