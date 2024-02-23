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

    getter choice_text = Crymon::Fields::ChoiceTextField.new
    getter choice_text_mult = Crymon::Fields::ChoiceTextMultField.new
    getter choice_text_dyn = Crymon::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = Crymon::Fields::ChoiceTextMultDynField.new

    getter choice_i64 = Crymon::Fields::ChoiceI64Field.new
    getter choice_i64_mult = Crymon::Fields::ChoiceI64MultField.new
    getter choice_i64_dyn = Crymon::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = Crymon::Fields::ChoiceI64MultDynField.new

    getter choice_f64 = Crymon::Fields::ChoiceF64Field.new
    getter choice_f64_mult = Crymon::Fields::ChoiceF64MultField.new
    getter choice_f64_dyn = Crymon::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = Crymon::Fields::ChoiceF64MultDynField.new

    getter i64 = Crymon::Fields::I64Field.new
    getter f64 = Crymon::Fields::F64Field.new

    getter bool = Crymon::Fields::BoolField.new
  end
end
