require "../../src/crymon"

# Structure for testing.
module Spec::Data
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
    getter date = Crymon::Fields::DateField.new
    getter datetime = Crymon::Fields::DateTimeField.new
    getter i64 = Crymon::Fields::I64Field.new
    getter f64 = Crymon::Fields::F64Field.new
    getter bool = Crymon::Fields::BoolField.new
  end
end
