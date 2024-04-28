require "i18n"
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
  DynFork::Migration::Monitor.new(
    "app_name": "AppName",
    "unique_app_key": "3i1Zh8c5Z0C5s5g6",
    "mongo_uri": "mongodb://localhost:27017",
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new

  # Add user data.
  user.username.value = "username"
  user.email.value = "user@noreaply.net"
  user.birthday.value = "2023-03-25"

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  user_list = Models::Accounts::User.find_many_to_hash_list
  pp user_list

  # Update user data.
  user.username.value = "username_2"
  user.email.value = "user_2@noreaply.net"
  user.birthday.value = "2024-04-26"

  # Save user.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  user_list = Models::Accounts::User.find_many_to_hash_list
  pp user_list

  puts "\n\nDocumwnt count: #{Models::Accounts::User.count_documents}"

  puts "\nDeleting a document."
  user.delete

  puts "\nDocumwnt count: #{Models::Accounts::User.estimated_document_count}"
end
