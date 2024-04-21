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
    "unique_app_key": "0U6r3itxQkF5l4Dx",
    "mongo_uri": "mongodb://localhost:27017",
  ).migrat

  puts "Documwnt count: #{Models::Accounts::User.estimated_document_count}" # => 3
end
