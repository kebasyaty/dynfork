require "../spec_helper"

# https://github.com/crab-cr/webslug
describe "WebSlug" do
  it "=> testing", tags: "webslug" do
    Iom::WebSlug.slug("i ♥ unicode").should eq "i-love-unicode"
    Iom::WebSlug.slug("I ♥ UNICODE").should eq "i-love-unicode"
    Iom::WebSlug.slug("i <3 unicode").should eq "i-love-unicode"
    Iom::WebSlug.slug("компютъра").should eq "kompyutura"
    Iom::WebSlug.slug("unicode ♥ is ☢").should eq "unicode-love-is-radioactive"
    Iom::WebSlug.slug("http://www.example.com").should eq "www-example-com"
    Iom::WebSlug.slug("Schlotsky's").should eq "schlotskys"
  end
end
