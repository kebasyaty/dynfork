require "i18n"
require "dynfork"
require "./models/*"

module AdditionalValidation
  VERSION = "0.1.0"

  # Initialize locale.
  I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
  I18n.config.default_locale = :en
  I18n.init
  
  # Run migration.
  DynFork::Migration::Monitor.new(
    "app_name": "AppName",
    "unique_app_key": "lL15C2zJW6f0C4OB",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::Accounts::User,
    }
  ).migrat
end
