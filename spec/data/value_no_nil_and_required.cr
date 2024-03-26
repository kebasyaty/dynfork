require "../../src/dynfork"

# Structure for testing.
module Spec::Data
  # A model with all parameters and fields by default.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct ValueNoNilAndRequired < DynFork::Model
    getter url = DynFork::Fields::URLField.new(required: true)
    getter text = DynFork::Fields::TextField.new(required: true)
    getter phone = DynFork::Fields::PhoneField.new(required: true)
    getter password = DynFork::Fields::PasswordField.new(required: true)
    getter ip = DynFork::Fields::IPField.new(required: true)
    getter hash2 = DynFork::Fields::HashField.new(required: true)
    getter email = DynFork::Fields::EmailField.new(required: true)
    getter color = DynFork::Fields::ColorField.new(required: true)
    getter slug = DynFork::Fields::SlugField.new

    getter date = DynFork::Fields::DateField.new(required: true)
    getter datetime = DynFork::Fields::DateTimeField.new(required: true)

    getter choice_text = DynFork::Fields::ChoiceTextField.new(
      choices: [{"value", "Title"}, {"value 2", "Title 2"}],
      required: true
    )
    getter choice_text_mult = DynFork::Fields::ChoiceTextMultField.new(
      choices: [{"value", "Title"}, {"value 2", "Title 2"}],
      required: true
    )
    getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new

    getter choice_i64 = DynFork::Fields::ChoiceI64Field.new(
      choices: [{5_i64, "Title"}, {10_i64, "Title 2"}],
      required: true
    )
    getter choice_i64_mult = DynFork::Fields::ChoiceI64MultField.new(
      choices: [{5_i64, "Title"}, {10_i64, "Title 2"}],
      required: true
    )
    getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new

    getter choice_f64 = DynFork::Fields::ChoiceF64Field.new(
      choices: [{5.0, "Title"}, {5.25, "Title 2"}],
      required: true
    )
    getter choice_f64_mult = DynFork::Fields::ChoiceF64MultField.new(
      choices: [{5.0, "Title"}, {5.25, "Title 2"}],
      required: true
    )
    getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new

    getter file = DynFork::Fields::FileField.new(required: true)
    getter image = DynFork::Fields::ImageField.new(required: true)

    getter i64 = DynFork::Fields::I64Field.new(required: true)
    getter f64 = DynFork::Fields::F64Field.new(required: true)

    getter bool = DynFork::Fields::BoolField.new
  end
end
