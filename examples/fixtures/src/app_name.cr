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
    database_name: "test_0U6r2itxQkF3l1Dx",
  ).migrat

  puts "Documwnt count: #{Models::Admin::SiteSettings.estimated_document_count}" # => 1
end
