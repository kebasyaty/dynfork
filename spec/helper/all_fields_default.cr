require "../../src/crymon"

# Structure for testing.
module Helper
  # A model with all parameters and fields by default.
  @[Crymon::Meta(service_name: "ServiceName")]
  struct AllFieldsDefault < Crymon::Model
    getter urlt = Crymon::Fields::URLField.new
    getter text = Crymon::Fields::TextField.new
    getter phone = Crymon::Fields::PhoneField.new
    getter password = Crymon::Fields::PasswordField.new
    getter ip = Crymon::Fields::IPField.new
    getter hash = Crymon::Fields::HashField.new
    getter email = Crymon::Fields::EmailField.new
    getter color = Crymon::Fields::ColorField.new
  end
end
