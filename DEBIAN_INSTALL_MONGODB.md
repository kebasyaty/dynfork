# Debian 12 `Bookworm`

### Add repository:

```shell
sudo apt install gnupg2 curl
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \
   https://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" | \
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
