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
    "unique_app_key": "73J2zQ1tJFV0cO98",
    "mongo_uri": "mongodb://localhost:27017",
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new

  # Add user data.
  user.username.value = "username"

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  if id = user.object_id?
    pp Models::Accounts::User.find_one_to_hash({_id: id})
  end

  # Update user data.
  user.avatar.from_path "assets/media/default/no_photo.jpeg"
  user.resume.from_path "assets/media/default/no_doc.odt"

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  if id = user.object_id?
    pp Models::Accounts::User.find_one_to_hash({_id: id})
  end
end
