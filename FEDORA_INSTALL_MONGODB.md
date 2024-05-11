# Fedora

### Add repository:

```shell
sudo tee /etc/yum.repos.d/mongodb.repo << "EOF" > /dev/null
[mongodb]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/${basearch}/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF
```

### Install:

```shell
sudo dnf makecache --refresh
sudo dnf update
sudo dnf install -y mongodb-org
mongo -version
sudo systemctl start mongod.service
sudo systemctl status mongod.service
sudo systemctl enable mongod.service
```
