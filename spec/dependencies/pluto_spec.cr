require "../spec_helper"

# https://github.com/phenopolis/pluto
describe "Crystal Pluto" do
  # sudo apt -y install libturbojpeg0-dev | libjpeg-turbo8-dev
  it "=> image jpeg", tags: "pluto" do
    image_jpeg = File.open("pictures/pluto.jpg") do |file|
      Pluto::ImageRGBA.from_jpeg(file)
    end
    image_jpeg.width.should eq(100)
    image_jpeg.height.should eq(100)
    image_jpeg.size.should eq(10000)
  end

  # TEMP_DEB="$(mktemp)"
  # wget --no-check-certificate -O "$TEMP_DEB" 'http://ftp.uk.debian.org/debian/pool/main/libs/libspng/libspng-dev_0.7.3-3_amd64.deb'
  # sudo dpkg -i "$TEMP_DEB"
  # rm -f "$TEMP_DEB"
  it "=> image png", tags: "pluto" do
    image_png = File.open("pictures/pluto.png") do |file|
      Pluto::ImageRGBA.from_png(file)
    end
    image_png.width.should eq(100)
    image_png.height.should eq(100)
    image_png.size.should eq(0)
  end
end
