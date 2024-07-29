# Fedora >= 40

**Your processor must support AVX/AVX2 instructions.**
```shell
# check
lscpu | grep avx
```

### Add repository:

```shell
sudo tee /etc/yum.repos.d/mongodb-org.repo << "EOF" > /dev/null
[mongodb-org]
name=MongoDB community Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF
```

### Install:

```shell
sudo dnf install mongodb-org
mongod --version
sudo systemctl start mongod
sudo systemctl status mongod --no-pager -l
sudo systemctl enable mongod
```

### Remove

```shell
sudo systemctl stop mongod
sudo systemctl disable mongod
sudo dnf erase $(rpm -qa | grep mongodb-org)
sudo rm -f /etc/yum.repos.d/mongodb-org.repo
sudo rm -r /var/log/mongodb /var/lib/mongo
sudo dnf makecache --refresh
```

