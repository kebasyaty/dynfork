require "./extra"
require "./paladins/paladins"
require "./commons/commons"

module DynFork
  # Abstraction for converting Crystal structures into DynFork Models.
  #
  # Simple example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  # ```
  #
  # Extended example:
  # ```
  # @[DynFork::Meta(
  #   service_name: "Accounts",
  #   delete_doc?: false,
  # )]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new(
  #     label: "Username",
  #     maxlength: 150,
  #     minlength: 1,
  #     regex: "^[a-zA-Z0-9_@.+]$",
  #     regex_err_msg: "Allowed chars: a-z A-Z 0-9 _ @ . +",
  #     required: true,
  #     unique: true
  #   )
  #   getter email = DynFork::Fields::EmailField.new(
  #     label: "E-mail",
  #     maxlength: 320,
  #     required: true,
  #     unique: true
  #   )
  #   getter birthday = DynFork::Fields::DateField.new(
  #     label: "Birthday",
  #   )
  #   getter slug = DynFork::Fields::SlugField.new(
  #     label: "Slug",
  #     slug_sources: ["hash", "username"]
  #   )
  #   getter password = DynFork::Fields::PasswordField.new(
  #     label: "Password",
  #   )
  #   # Do not save the value of this field to the database.
  #   # This field is for verification purposes only.
  #   getter confirm_password = DynFork::Fields::PasswordField.new(
  #     label: "Confirm password",
  #     ignored: true
  #   )
  #   getter active = DynFork::Fields::BoolField.new(
  #     label: "is active?",
  #     default: true
  #   )
  # end
  # ```
  #
  @[DynFork::Meta]
  abstract struct Model < DynFork::Extra
    include JSON::Serializable
    include DynFork::Globals::Date
    include DynFork::QPaladins
    extend DynFork::QCommons

    # Field for the document identifier.
    # NOTE: **Example:** `507c7f79bcf86cd7994f6c0e`
    getter hash = DynFork::Fields::HashField
      .new(hide: true, ignored: true, disabled: true)
    # Field for the date and time the document was created.
    # NOTE: **Example:** `1970-01-01T00:00:00`
    getter created_at = DynFork::Fields::DateTimeField
      .new(label: I18n.t(:created_at), warning: [I18n.t(:doc_was_created)], hide: true, disabled: true)
    # Field for the date and time the document was updated.
    # NOTE: **Example:** `1970-01-01T00:00:00`
    getter updated_at = DynFork::Fields::DateTimeField
      .new(label: I18n.t(:updated_at), warning: [I18n.t(:doc_was_updated)], hide: true, disabled: true)
    # Get full Model name = ModuleName::StructureName.
    # NOTE: **Examples:** _Accounts::User | Accounts::UserProfile | Cars::ElectricCar | etc ..._
    class_getter full_model_name : String = ""
    # Metadata cache.
    class_getter! meta : DynFork::Globals::CacheMetaDataType?

    def initialize
      self.caching if @@meta.nil?
      self.inject
    end

    # Injecting metadata from ModelName.meta in params of fields.
    private def inject : Nil
      field_name : String = ""
      json : String?
      #  Add the values of the attributes **id** and **name** from `@@meta`.
      {% for var in @type.instance_vars %}
        field_name = {{ var.name.stringify }}
        field_attrs = @@meta.not_nil![:field_attrs][field_name]
        @{{ var }}.id = field_attrs[:id]
        @{{ var }}.name = field_attrs[:name]
        # Add data for dynamic fields from `@@meta`.
        if json = @@meta.not_nil![:data_dynamic_fields][field_name]?
          @{{ var }}.choices_from_json(json)
        end
      {% end %}
    end

    # Get ObjectId from hash field.
    def object_id : BSON::ObjectId?
      if value : String? = @hash.value?.presence
        return BSON::ObjectId.new(value.not_nil!)
      end
    end

    # Get a list of Models.
    def self.subclasses
      {{@type.subclasses}}
    end
  end
end
