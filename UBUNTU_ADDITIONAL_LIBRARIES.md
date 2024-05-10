# Ubuntu | Linux Mint

### Install:

```shell
sudo apt -y install libturbojpeg0 &&
sudo apt -y install libturbojpeg0-dev &&
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" 'https://deb.debian.org/debian/pool/main/libs/libspng/libspng0_0.7.3-3_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB" &&
wget -O "$TEMP_DEB" 'https://deb.debian.org/debian/pool/main/libs/libspng/libspng-dev_0.7.3-3_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB" &&
sudo apt -y install libwebp-dev &&
wget -O "$TEMP_DEB"  'https://deb.debian.org/debian/pool/main/libw/libwebp/libsharpyuv0_1.3.2-0.4+b1_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB" &&
wget -O "$TEMP_DEB"  'https://deb.debian.org/debian/pool/main/libw/libwebp/libsharpyuv-dev_1.3.2-0.4+b1_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB" &&
rm -f "$TEMP_DEB"
```
