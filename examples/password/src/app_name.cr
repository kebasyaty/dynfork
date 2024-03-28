require "i18n"
require "dynfork"
require "./models/*"

module AppName
  VERSION = "0.1.0"

  # Initialize locale.
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

  # Save user (print_err - convenient for development).
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
