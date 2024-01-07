require "../spec_helper"

# https://github.com/phenopolis/pluto
# sudo apt -y install libturbojpeg-dev libpng-tools libwebp-dev
describe "Crystal Pluto" do
  it "=> image jpeg", tags: "pluto" do
    image_jpeg = File.open("pictures/pluto.jpg") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_jpeg.width.should eq(100)
    image_jpeg.height.should eq(100)
    image_jpeg.size.should eq(10000)
  end
end
