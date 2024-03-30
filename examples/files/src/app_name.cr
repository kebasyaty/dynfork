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
    "unique_app_key": "73J2zQ1tJFV0cO95",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::Accounts::User,
    }
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new
  # Add user details.
  user.username.value = "username"

  # Run save.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save?
  # Print user data.
  puts "\n# New user details:"
  puts "hash: #{user.hash.value?}"
  puts "username: #{user.username.value?}"
  puts "avatar: #{user.avatar.value?}"
  puts "resume: #{user.resume.value?}"
  puts "created_at: #{user.created_at.value?}"
  puts "updated_at: #{user.updated_at.value?}"

  # Update user data.
  user.avatar.path_to_file "assets/media/default/no_photo.jpeg"
  user.resume.path_to_file "assets/media/default/no_doc.odt"
  # Run update.
  user.print_err unless user.save?
  # Print user data.
  puts "\n# Updated user information:"
  puts "hash: #{user.hash.value?}"
  puts "username: #{user.username.value?}"
  puts "avatar: #{user.avatar.value?}"
  puts "resume: #{user.resume.value?}"
  puts "created_at: #{user.created_at.value?}"
  puts "updated_at: #{user.updated_at.value?}"
end
