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
    unique_app_key: "22915V44DssD7f33",
    mongo_client: Mongo::Client.new("mongodb://localhost:27017")
  ).migrat

  # Create a tv.
  tv = Models::TVs::TV.new

  # Select the TV model.
  tv.model.value = "big-tv"
  tv.included.value = [1_i64, 2_i64, 3_i64]

  # Save .
  # Hint: print_err - convenient for development.
  tv.print_err unless tv.save

  # Print tv details.
  puts "\n\nTV details:"
  if id = user.object_id?
    pp Models::TVs::TV.find_one_to_hash({_id: id})
  end
end
