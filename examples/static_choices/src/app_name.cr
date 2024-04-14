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
    "unique_app_key": "22915V44DssD7f33",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::TVs::TV,
    }
  ).migrat

  # Create a tv.
  tv = Models::TVs::TV.new
  # Select the TV model.
  tv.model.value = "big-tv"
  tv.included.value = [1_i64, 2_i64, 3_i64]

  # Run save.
  # Hint: print_err - convenient for development.
  tv.print_err unless tv.save
  # Print tv data.
  puts "\n# TV details:"
  puts "hash: #{tv.hash.value?}"
  puts "model: #{tv.model.value?}"
  puts "included: #{tv.included.value?}"
  puts "created_at: #{tv.created_at.value?}"
  puts "updated_at: #{tv.updated_at.value?}"
end
