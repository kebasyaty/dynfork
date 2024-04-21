require "../../src/dynfork"

# Structures for testing.
module Spec::Data
  # For the test - Update password.
  @[DynFork::Meta(service_name: "Accounts")]
  struct UpdatePassword < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
  end
end
