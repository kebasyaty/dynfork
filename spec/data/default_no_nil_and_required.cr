require "../../src/dynfork"

# Structure for testing.
module Spec::Data
  # Model with overridden _default_ parameter for all fields.
  @[DynFork::Meta(service_name: "ServiceName")]
  struct DefaultNoNilAndRequired < DynFork::Model
    getter url = DynFork::Fields::URLField.new(default: "https://translate.google.com/", required: true)
    getter text = DynFork::Fields::TextField.new(default: "Some text", required: true)
    getter phone = DynFork::Fields::PhoneField.new(default: "+18004444444", required: true)
    getter password = DynFork::Fields::PasswordField.new(required: true)
    getter ip = DynFork::Fields::IPField.new(default: "126.255.255.255", required: true)
    getter hash2 = DynFork::Fields::HashField.new(required: true, unique: false)
    getter email = DynFork::Fields::EmailField.new(default: "john.smith@example.com", required: true)
    getter color = DynFork::Fields::ColorField.new(default: "#ff0000", required: true)
    getter slug = DynFork::Fields::SlugField.new

    getter date = DynFork::Fields::DateField.new(default: "1970-01-01", required: true)
    getter datetime = DynFork::Fields::DateTimeField.new(default: "1970-01-01T00:00:00", required: true)

    getter choice_text = DynFork::Fields::ChoiceTextField.new(
      default: "value",
      choices: [{"value", "Title"}, {"value 2", "Title 2"}],
      required: true
    )
    getter choice_text_mult = DynFork::Fields::ChoiceTextMultField.new(
      default: ["value"],
      choices: [{"value", "Title"}, {"value 2", "Title 2"}],
      required: true
    )
    getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new

    getter choice_i64 = DynFork::Fields::ChoiceI64Field.new(
      default: 5_i64,
      choices: [{5_i64, "Title"}, {10_i64, "Title 2"}],
      required: true
    )
    getter choice_i64_mult = DynFork::Fields::ChoiceI64MultField.new(
      default: [5_i64],
      choices: [{5_i64, "Title"}, {10_i64, "Title 2"}],
      required: true
    )
    getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new

    getter choice_f64 = DynFork::Fields::ChoiceF64Field.new(
      default: 5.0,
      choices: [{5.0, "Title"}, {5.25, "Title 2"}],
    )
    getter choice_f64_mult = DynFork::Fields::ChoiceF64MultField.new(
      default: [5.0],
      choices: [{5.0, "Title"}, {5.25, "Title 2"}],
    )
    getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new

    getter file = DynFork::Fields::FileField.new(
      default: "public/media/default/no_doc.odt",
      required: true
    )
    getter image = DynFork::Fields::ImageField.new(
      default: "public/media/default/no_photo.jpeg",
      required: true
    )

    getter i64 = DynFork::Fields::I64Field.new(default: 10_i64, required: true)
    getter f64 = DynFork::Fields::F64Field.new(default: 10.2, required: true)

    getter bool = DynFork::Fields::BoolField.new(default: true)
  end
end
