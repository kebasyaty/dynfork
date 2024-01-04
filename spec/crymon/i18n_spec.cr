require "../spec_helper"

# https://github.com/crystal-i18n/i18n
describe "Crystal I18n" do
  it "=> testing I18n", tags: "i18n" do
    I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
    I18n.config.default_locale = :en
    I18n.init

    I18n.t(:required_field).should eq("Required field.")
  end
end
