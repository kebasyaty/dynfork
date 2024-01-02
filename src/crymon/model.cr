require "json"
require "./paladins/aa"
require "./paladins/paladins"

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
  # Extended example:
  # ```
  # @[Crymon::Meta(
  #   service_name: "Accounts",
  #   is_deleting_docs: false
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
  @[Crymon::Meta]
  abstract struct Model < Crymon::AA
    include JSON::Serializable
    include JSON::Serializable::Strict
    include Crymon::Tools::Date
    include Crymon::Paladins

    getter hash = Crymon::Fields::HashField.new("is_ignored": true)
    getter created_at = Crymon::Fields::DateTimeField
      .new("label": "Created at", "is_hide": true)
    getter updated_at = Crymon::Fields::DateTimeField
      .new("label": "Updated at", "is_hide": true)
    # Metadata caching.
    class_getter meta : Crymon::Globals::CacheMetaDataType?

    def initialize
      # name = {{ @type.annotation }}
      self.caching if @@meta.nil?
      self.inject
    end

    # Injecting metadata from storage in Model.
    def inject
      var_name : String = ""
      json : String?
      # Add the values of the attributes **id** and **name** from the cache to the Model.
      {% for var in @type.instance_vars %}
        var_name = {{ var.name.stringify }}
        field_attrs = @@meta.not_nil![:field_attrs][var_name]
        @{{ var }}.id = field_attrs[:id]
        @{{ var }}.name = field_attrs[:name]
        # Add dynamic field data from the cache to the Model.
        if json = @@meta.not_nil![:data_dynamic_fields][var_name]?
          @{{ var }}.set_choices(json)
        end
      {% end %}
    end

    # Get Model name = Structure name.
    # <br>
    # **Examples:** _User | UserProfile | ElectricCar | etc ..._
    # WARNING: Maximum 25 characters.
    def model_name : String
      {{ @type.name.stringify }}.split("::").last
    end

    # Get ObjectId from hash field.
    def get_object_id : BSON::ObjectId?
      BSON::ObjectId.new(@hash.value.not_nil!) unless @hash.value.nil?
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
