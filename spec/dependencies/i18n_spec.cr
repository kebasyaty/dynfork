require "../spec_helper"

# https://github.com/crystal-i18n/i18n
describe "Crystal I18n" do
  it "=> testing lib", tags: "i18n" do
    I18n.t(:required_field).should eq("Required field!")
    #
    I18n.with_locale(:ru) do
      I18n.t(:required_field).should eq("Обязательное поле!")
    end
    #
    I18n.t(:required_field).should eq("Required field!")
    #
    I18n.with_locale(:eo) do
      I18n.t(:required_field).should eq("Bezonata kampo!")
    end
    #
    I18n.t(:required_field).should eq("Required field!")
  end
end
