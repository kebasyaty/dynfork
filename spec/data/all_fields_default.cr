require "../../src/dynfork"

# Structure for testing.
module Spec::Data
  # A model with all parameters and fields by default.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct AllFieldsDefault < DynFork::Model
    getter urlt = DynFork::Fields::URLField.new
    getter text = DynFork::Fields::TextField.new
    getter phone = DynFork::Fields::PhoneField.new
    getter password = DynFork::Fields::PasswordField.new
    getter ip = DynFork::Fields::IPField.new
    getter hash = DynFork::Fields::HashField.new
    getter email = DynFork::Fields::EmailField.new
    getter color = DynFork::Fields::ColorField.new

    getter date = DynFork::Fields::DateField.new
    getter datetime = DynFork::Fields::DateTimeField.new

    getter choice_text = DynFork::Fields::ChoiceTextField.new
    getter choice_text_mult = DynFork::Fields::ChoiceTextMultField.new
    getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new

    getter choice_i64 = DynFork::Fields::ChoiceI64Field.new
    getter choice_i64_mult = DynFork::Fields::ChoiceI64MultField.new
    getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new

    getter choice_f64 = DynFork::Fields::ChoiceF64Field.new
    getter choice_f64_mult = DynFork::Fields::ChoiceF64MultField.new
    getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new

    getter file = DynFork::Fields::FileField.new

    getter f64 = DynFork::Fields::F64Field.new

    getter bool = DynFork::Fields::BoolField.new
  end
end
