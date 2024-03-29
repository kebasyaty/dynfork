module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    # WARNING: Default regular expression: /^[-._!"`'#%&,:;<>=@{}~\$\(\)\*\+\/\\\?\[\]\^\|a-zA-Z0-9]+$/
    # WARNING: Valid characters by default: a-z A-Z 0-9 - . _ ! " ` ' # % & , : ; < > = @ { } ~ $ ( ) * + / \ ? [ ] ^ |
    # WARNING: Default number of characters: max = 256, min = 8
    getter password = DynFork::Fields::PasswordField.new
  end
end
