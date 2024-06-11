# Ubuntu 22.04 | Linux Mint 21.3

**Your processor must support AVX/AVX2 instructions.**
```shell
# check
lscpu | grep avx
```

### Add repository:

```shell
sudo apt install gnupg2 curl
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
   https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
```

### Install:

```shell
sudo apt install -y mongodb-org
mongod --version
sudo systemctl start mongod
sudo systemctl status mongod
sudo systemctl enable mongod

```
