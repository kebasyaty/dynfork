require "../../src/dynfork"

# Structures for testing.
module Spec::Data
  # Test removing a document from a collection.
  @[DynFork::Meta(service_name: "Accounts")]
  struct DeleteModel < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter password = DynFork::Fields::PasswordField.new
  end
end
