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
    database_name: "test_73J2zQ1tJFV0cO98",
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
  user.avatar.from_path "public/media/default/no_photo.jpeg"
  user.resume.from_path "public/media/default/no_doc.odt"

  # Save user.
  # Hint: print_err - convenient for development.
  user.print_err unless user.save

  # Print user details.
  puts "\n\nUser details:"
  if id = user.object_id?
    pp Models::Accounts::User.find_one_to_hash({_id: id})
  end
end
