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

  it "=> testing ip", tags: "validator" do
    # Negative:
    # Valid.ip?("").should be_false # Index out of bounds (IndexError)
    # Valid.ip?("::").should be_false # Index out of bounds (IndexError)
    Valid.ip?("10.0.0.0/8").should be_false
    Valid.ip?("172.16.0.0/12").should be_false
    Valid.ip?("192.168.0.0/16").should be_false
    Valid.ip?("169.254.0.0/24").should be_false
    Valid.ip?("FF02:0:0:0:0:1:FF00::/104").should be_false
    Valid.ip?("FF02:0:0:0:0:1:FF00::").should be_false
    Valid.ip?("FF02:0:0:0:0:1:FF00").should be_false
    Valid.ip?("2345:425:2CA1:0000:0000:567:5673:23b5/64").should be_false
    # Positive:
    Valid.ip?("192.0.2.2").should be_true
    Valid.ip?("100.64.2.2").should be_true
    Valid.ip?("172.16.0.0").should be_true
    Valid.ip?("192.168.0.0").should be_true
    Valid.ip?("169.254.1.0").should be_true
    Valid.ip?("169.254.254.255").should be_true
    Valid.ip?("169.254.0.0").should be_true
    Valid.ip?("169.254.255.0").should be_true
    Valid.ip?("255.255.255.255").should be_true
    Valid.ip?("198.18.0.0").should be_true
    Valid.ip?("::ffff:192.0.2.1").should be_true
    Valid.ip?("3001:0da8:75a3:0000:0000:8a2e:0370:7334").should be_true
    Valid.ip?("2345:0425:2CA1:0000:0000:0567:5673:23b5").should be_true
    Valid.ip?("2345:0425:2CA1::0567:5673:23b5").should be_true
  end

  it "=> testing color", tags: "validator" do
    # Negative:
    Valid.color?("").should be_false
    Valid.color?("#f2ewq").should be_false
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

  it "=> testing json", tags: "validator" do
    # Negative:
    Valid.json?("{x:5,'y':6}").should be_false
    # Positive:
    Valid.json?("{\"x\":[10,null,null,null]}").should be_true
  end

  it "=> testing mongo_id", tags: "validator" do
    # Negative:
    Valid.mongo_id?("507f191e810c19729de860e").should be_false
    Valid.mongo_id?("507f191e810c19729de860ea1").should be_false
    Valid.mongo_id?("507f191e810c19729de860eg").should be_false
    Valid.mongo_id?("507f191e810c19729de860e?").should be_false
    # Positive:
    Valid.mongo_id?("507f191e810c19729de860ea").should be_true
  end
end
