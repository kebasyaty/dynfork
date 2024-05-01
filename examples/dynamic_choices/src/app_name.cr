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
    app_name: "AppName",
    unique_app_key: "8NhUINI8vJ87mxbk",
    mongo_client: Mongo::Client.new("mongodb://localhost:27017")
  ).migrat

  # Add a key-value for a dynamic field.
  unit = DynFork::Globals::Unit.new(
    field: "choice_text_dyn",
    title: "Title 1",
    value: "value 1", # String | Int64 | Float64
    delete: false     # default is the same as false
  )
  Models::Accounts::User.unit_manager(unit)

  # Create a user.
  user = Models::Accounts::User.new
  user.choice_text_dyn.value = "value 1"
  user.print_err unless user.save

  puts "Model State:"
  super_collection = DynFork::Globals.mongo_database[
    DynFork::Globals.super_collection_name]
  filter = {"collection_name": Models::Accounts::User.meta["collection_name"]}
  if model_state = super_collection.find_one(filter)
    pp model_state.not_nil!.to_h
  end

  puts "\n\nMeta > `data_dynamic_fields`:"
  pp Models::Accounts::User.meta[:data_dynamic_fields]

  puts "\n\nUsers:"
  user_list = Models::Accounts::User.find_many_to_hash_list
  pp user_list

  # user.delete
end
