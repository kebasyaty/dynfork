require "../../src/dynfork"

# Structures for testing.
module Spec::Data
  @[DynFork::Meta(service_name: "Accounts")]
  struct DynFieldsModel < DynFork::Model
    # test
    getter choice_text_dyn = DynFork::Fields::ChoiceTextDynField.new
    getter choice_text_mult_dyn = DynFork::Fields::ChoiceTextMultDynField.new
    # i64
    getter choice_i64_dyn = DynFork::Fields::ChoiceI64DynField.new
    getter choice_i64_mult_dyn = DynFork::Fields::ChoiceI64MultDynField.new
    # f64
    getter choice_f64_dyn = DynFork::Fields::ChoiceF64DynField.new
    getter choice_f64_mult_dyn = DynFork::Fields::ChoiceF64MultDynField.new
  end
end
