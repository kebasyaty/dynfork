module Models::Accounts
  @[DynFork::Meta(
    service_name: "Accounts",
    fixture_name: "Users",
    migrat_model?: true,
    create_doc?: true,
    update_doc?: true,
    delete_doc?: false,
  )]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(unique: true)
    getter email = DynFork::Fields::EmailField.new(unique: true)
    getter password = DynFork::Fields::PasswordField.new
    getter? active = DynFork::Fields::BoolField.new
  end
end
