require "./aa"
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
  #   deleting_docs?: false
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
  abstract struct Model < DynFork::AA
    include JSON::Serializable
    include DynFork::Globals::Date
    include DynFork::Paladins
    extend DynFork::Commons

    getter hash = DynFork::Fields::HashField
      .new(label: "Hash", hide: true, unique: true, ignored: true)
    getter created_at = DynFork::Fields::DateTimeField
      .new(label: "Created at", hide: true, readonly: true)
    getter updated_at = DynFork::Fields::DateTimeField
      .new(label: "Updated at", hide: true, readonly: true)
    # Get full Model name = ModuleName::StructureName.
    # <br>
    # **Examples:** _Accounts::User | Accounts::UserProfile | Cars::ElectricCar | etc ..._
    class_getter full_model_name : String = ""
    # Metadata cache.
    class_getter! meta : DynFork::Globals::CacheMetaDataType?

    def initialize
      self.caching if @@meta.nil?
      self.inject
    end

    # Injecting metadata from storage in Model.
    private def inject : Nil
      var_name : String = ""
      json : String?
      #  Add the values of the attributes **id** and **name** from the local `@@meta` cache.
      {% for var in @type.instance_vars %}
        var_name = {{ var.name.stringify }}
        field_attrs = @@meta.not_nil![:field_attrs][var_name]
        @{{ var }}.id = field_attrs[:id]
        @{{ var }}.name = field_attrs[:name]
        # Add data for dynamic fields from the local `@@meta` cache.
        if json = @@meta.not_nil![:data_dynamic_fields][var_name]?
          @{{ var }}.choices_from_json(json)
        end
      {% end %}
    end

    # Get ObjectId from hash field.
    def object_id? : BSON::ObjectId?
      if value : String? = @hash.value?.presence
        unless BSON::ObjectId.validate(value.not_nil!)
          msg = "Model: `#{@@full_model_name}` > " +
                "Field: `hash` => The hash field value is not valid."
          raise DynFork::Errors::Panic.new msg
        end
        return BSON::ObjectId.new(value.not_nil!)
      end
      nil
    end

    # Get a list of Models.
    def self.subclasses : Array(DynFork::Model.class)
      {{@type.subclasses}}
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
