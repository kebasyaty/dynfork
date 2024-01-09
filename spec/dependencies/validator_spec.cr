require "../spec_helper"

# https://github.com/Nicolab/crystal-validator
describe "Crystal Validator" do
  it "=> testing email", tags: "validator" do
    # Negative:
    Valid.email?("contact@@example.org").should be_false
    # Positive:
    Valid.email?("contact@example.org").should be_true
  end

  it "=> testing url", tags: "validator" do
    # Negative:
    Valid.url?("https:///github.com/Nicolab/crystal-validator").should be_false
    # Positive:
    Valid.url?("https://github.com/Nicolab/crystal-validator").should be_true
    Valid.url?("http://github.com/Nicolab/crystal-validator").should be_true
  end

  it "=> testing color", tags: "validator" do
    # Negative:
    Valid.color?("").should be_false
    Valid.color?("#f2ewq").should be_false
    Valid.color?(10).should be_false
    Valid.color?(10.1).should be_false
    Valid.color?(nil).should be_false
    Valid.color?(Array(String)).should be_false
    Valid.color?(Hash(String, String)).should be_false
    # Positive:
    Valid.color?("#fff").should be_true
    Valid.color?("#f2f2f2").should be_true
    Valid.color?("#F2F2F2").should be_true
    Valid.color?("#00000000").should be_true
    Valid.color?("rgb(255,0,24)").should be_true
    Valid.color?("rgb(255, 0, 24)").should be_true
    Valid.color?("rgba(255, 0, 24, .5)").should be_true
    Valid.color?("rgba(#fff, .5)").should be_true
    Valid.color?("rgba(#fff,.5)").should be_true
    Valid.color?("rgba(#FFF, .5)").should be_true
    Valid.color?("rgba(#FFF,.5)").should be_true
    Valid.color?("hsl(120, 100%, 50%)").should be_true
    Valid.color?("hsl(120,100%,50%)").should be_true
    Valid.color?("hsla(170, 23%, 25%, 0.2)").should be_true
    Valid.color?("hsla(170,23%,25%,0.2)").should be_true
    Valid.color?("0x00ffff").should be_true
    Valid.color?("0x00FFFF").should be_true
  end
end
