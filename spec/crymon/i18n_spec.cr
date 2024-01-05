require "../spec_helper"

# https://github.com/crystal-i18n/i18n
describe "Crystal I18n" do
  it "=> testing I18n", tags: "i18n" do
    I18n.t(:required_field).should eq("Required field.")
  end
end
