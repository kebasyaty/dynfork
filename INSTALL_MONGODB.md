# Ubuntu, Linux Mint

### Install:

```shell
$ sudo apt update
$ sudo apt install dirmngr gnupg apt-transport-https ca-certificates
$ wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
$ sudo add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse'
$ sudo apt update
$ sudo apt install mongodb-org
$ sudo systemctl enable --now mongod
```

#### For check:

```shell
$ mongod --version
$ mongo --eval 'db.runCommand({ connectionStatus: 1 })'
$ reboot
```

### Systemd:

```shell
$ sudo systemctl status mongod
$ sudo systemctl start mongod
$ sudo systemctl stop mongod
$ sudo systemctl restart mongod
$ sudo systemctl enable mongod
$ sudo systemctl disable mongod
```

### Configuration file:

```shell
$ sudo nano /etc/mongod.conf
```

### Uninstall:

```shell
$ sudo systemctl stop mongod
$ sudo systemctl disable mongod
$ sudo apt --purge remove mongodb\* # OR (for mongodb-org) - $ sudo apt --purge remove mongodb-org\*\*
$ sudo rm -r /var/log/mongodb
$ sudo rm -r /var/lib/mongodb
$ sudo rm -f /etc/mongod.conf
$ sudo apt-add-repository --remove 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' # for mongodb-org
$ sudo apt update
```

# Fedora

### Add repository:

```shell
$ sudo nano /etc/yum.repos.d/mongodb.repo
```

#### Add this text:

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
sudo systemctl stop mongod.service &&
sudo systemctl disable mongod.service &&
sudo dnf -y remove mongodb-org* &&
sudo rm -f /etc/yum.repos.d/mongodb.repo &&
sudo dnf -y update
# May be missing:
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongo
```
