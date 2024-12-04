module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter email = DynFork::Fields::EmailField.new
    getter birthday = DynFork::Fields::DateField.new
  end
end
