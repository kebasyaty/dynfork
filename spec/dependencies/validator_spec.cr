require "../spec_helper"

# https://github.com/Nicolab/crystal-validator
describe "Crystal Validator" do
  it "=> testing email", tags: "validator" do
    Valid.email?("contact@example.org").should be_true
    Valid.email?("contact@@example.org").should be_false
  end

  it "=> testing url", tags: "validator" do
    Valid.url?("https://github.com/Nicolab/crystal-validator").should be_true
    Valid.url?("http://github.com/Nicolab/crystal-validator").should be_true
    Valid.url?("https:///github.com/Nicolab/crystal-validator").should be_false
  end
end
