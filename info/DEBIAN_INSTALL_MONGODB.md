# Debian 12 `Bookworm`

**Your processor must support AVX/AVX2 instructions.**

```shell
# check
grep -qm1 '^flags.*avx' /proc/cpuinfo && echo OK || echo NOT OK
```

### Add repository:

```shell
sudo apt install -y curl gnupg2
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] \
   https://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
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
