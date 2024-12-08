#!/bin/bash

set -e

apt update

# Install OS dependencies
apt install -y curl gnupg2 systemctl git

# Install graphic libraries
apt install -y libturbojpeg libturbojpeg0-dev \
    libspng0 libspng-dev libwebp-dev libsharpyuv0 libsharpyuv-dev

# Install MongoDB server
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
    gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] \
    https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-8.0.list
apt update
apt install -y mongodb-org
mongod --version
systemctl start mongod
