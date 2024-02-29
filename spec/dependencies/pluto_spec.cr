require "../spec_helper"

# https://github.com/phenopolis/pluto
describe "Crystal Pluto" do
  it "=> image jpeg", tags: "pluto" do
    image_jpeg = File.open("pictures/pluto_1.jpg") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_jpeg.width.should eq(100)
    image_jpeg.height.should eq(100)
    image_jpeg.size.should eq(10000) # width x height
  end

  it "=> image png", tags: "pluto" do
    image_png = File.open("pictures/pluto_2.png") do |file|
      Pluto::ImageRGBA.from_png(file)
    end
    image_png.width.should eq(100)
    image_png.height.should eq(100)
    image_png.size.should eq(10000) # width x height
  end

  it "=> image webp", tags: "pluto" do
    image_webp = File.open("pictures/pluto_3.webp") do |file|
      Pluto::ImageRGBA.from_webp(file)
    end
    image_webp.width.should eq(100)
    image_webp.height.should eq(100)
    image_webp.size.should eq(10000) # width x height
  end
end
