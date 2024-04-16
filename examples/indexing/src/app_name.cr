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
    "unique_app_key": "k76BQPF6d5e8nts9",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::Accounts::User,
    }
  ).migrat

  if cursor : Mongo::Cursor? = Models::Accounts::User.list_indexes
    cursor.not_nil!.each { |doc|
      puts doc.to_h
    }
  else
    raise "The index list returned an empty cursor!"
  end
end
