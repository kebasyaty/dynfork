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
    # WARNING: Maximum 60 characters.
    # WARNING: Match regular expression: /^[a-zA-Z][-_a-zA-Z0-9]{0,59}$/
    # NOTE: Not a mandatory format for development and tests: `test_<key>`
    # NOTE: To generate a `<key>` (This is not an advertisement): https://randompasswordgen.com/
    database_name: "test_lL15C2zJW6f0C4OH",
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new

  # Add user data.
  user.username.value = "username"
  user.email.value = "user@noreaply.net"
  user.birthday.value = "2023-03-25"
  user.password.value = "E2ep4e3UPkWs84GO"
  user.confirm_password.value = "E2ep4e3UPkWs84GO"

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  if id = user.object_id?
    pp Models::Accounts::User.find_one_to_hash({_id: id})
  end

  # Update user data.
  user.username.value = "username_2"
  user.email.value = "user_2@noreaply.net"
  user.birthday.value = "2024-04-26"
  user.is_active.value = false

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  if id = user.object_id?
    pp Models::Accounts::User.find_one_to_hash({_id: id})
  end
end
