require "dynfork"
require "./models/*"

module AppName
  VERSION = "0.1.0"

  # Initialize locale.
  # https://github.com/crystal-i18n/i18n
  I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
  I18n.config.default_locale = :en
  I18n.init

  # Run migration.
  # https://elbywan.github.io/cryomongo/Mongo/Client.html
  DynFork::Migration::Monitor.new(
    app_name: "AppName",
    unique_app_key: "3i1Zh8c5Z0C5s5g6",
    mongo_client: Mongo::Client.new("mongodb://localhost:27017")
  ).migrat

  # Create user.
  puts "Create user"
  user = Models::Accounts::User.new
  user.username.value = "username"
  user.email.value = "user@noreaply.net"
  user.birthday.value = "2023-03-25"
  user.print_err unless user.save

  # Update user.
  puts "Update user"
  user.username.value = "username_2"
  user.email.value = "user_2@noreaply.net"
  user.birthday.value = "2024-04-26"
  user.print_err unless user.save

  # Delete user.
  puts "Delete user"
  user.delete
end
