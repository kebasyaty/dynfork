# Fedora

### Add repository:

```shell
$ sudo nano /etc/yum.repos.d/mongodb.repo
```

###### Add this text:

```text
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
```

### Install:

```shell
$ sudo dnf makecache --refresh
$ sudo dnf update
$ sudo dnf install -y mongodb-org
$ mongo -version
$ sudo systemctl start mongod.service
$ sudo systemctl status mongod.service
$ sudo systemctl enable mongod.service
```

### Uninstall:

```shell
sudo systemctl stop mongod.service
sudo systemctl disable mongod.service
sudo dnf -y remove mongodb-org*
sudo rm -f /etc/yum.repos.d/mongodb.repo
sudo dnf -y update
# May be missing:
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongo
```
