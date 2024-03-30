require "i18n"
require "dynfork"
require "./models/*"

module AppName
  VERSION = "0.1.0"

  # Password:
  # WARNING: Default regular expression: /^[-._!"`'#%&,:;<>=@{}~\$\(\)\*\+\/\\\?\[\]\^\|a-zA-Z0-9]+$/
  # WARNING: Valid characters by default: a-z A-Z 0-9 - . _ ! " ` ' # % & , : ; < > = @ { } ~ $ ( ) * + / \ ? [ ] ^ |
  # WARNING: Default number of characters: max = 256, min = 8

  # Initialize locale.
  # https://github.com/crystal-i18n/i18n
  I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
  I18n.config.default_locale = :en
  I18n.init

  # Run migration.
  DynFork::Migration::Monitor.new(
    "app_name": "AppName",
    "unique_app_key": "lk5Ev5471gC2u1R5",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::Accounts::User,
    }
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new

  password = "7637Kw8#5GTb~]H#"
  new_password = "$3{q1!8/+~'8+x29"

  # Add user details.
  user.username.value = "username"
  user.password.value = password

  # Run save.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save?

  # Verify password.
  if user.verify_password?(password)
    puts "The password matche."
  else
    puts "The password does not match."
  end

  # Update password.
  user.update_password(
    old_password: password,
    new_password: new_password
  )

  # Verify password.
  if user.verify_password?(new_password)
    puts "The password matche."
  else
    puts "The password does not match."
  end
end
