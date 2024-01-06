require "../spec_helper"

# https://github.com/phenopolis/pluto
describe "Crystal Pluto" do
  it "=> testing lib", tags: "pluto" do
    image_jpeg = File.open("pictures/pluto.jpg") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_jpeg.width.should eq(100)
    image_jpeg.height.should eq(100)
    image_jpeg.size.should eq(10000)
    #
    image_png = File.open("pictures/pluto.png") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_png.width.should eq(100)
    image_png.height.should eq(100)
    image_png.size.should eq(10000)
    #
    image_webp = File.open("pictures/pluto.webp") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_webp.width.should eq(100)
    image_webp.height.should eq(100)
    image_webp.size.should eq(10000)
  end
end
