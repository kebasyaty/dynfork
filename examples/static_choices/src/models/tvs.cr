module Models::TVs
  @[DynFork::Meta(service_name: "TVs")]
  struct TV < DynFork::Model
    getter model = DynFork::Fields::ChoiceTextField.new(
      default: "cool-tv",
      choices: [{"cool-tv", "Cool TV"}, {"big-tv", "Big TV"}]
    )
    getter included = DynFork::Fields::ChoiceI64MultField.new(
      default: [1_i64, 2_i64],
      choices: [{1_i64, "Package"}, {2_i64, "Instructions"}, {3_i64, "Satellite Dish"}]
    )
  end
end
