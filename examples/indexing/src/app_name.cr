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
    database_name: "test_k76BQPF6d5e8nts9",
  ).migrat

  if cursor : Mongo::Cursor? = Models::Accounts::User.list_indexes
    cursor.not_nil!.each { |doc|
      puts doc.to_h
    }
  else
    raise "The index list returned an empty cursor!"
  end
end
