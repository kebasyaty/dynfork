# app_name

An example of a fixture with several documents.
<br>
**Fixtures** - To populate the database with pre-created data.
<br>
**config/fixtures** - Directory for creating fixtures.

## Installation

1. Install MongoDB (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_INSTALL_MONGODB.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_INSTALL_MONGODB.md)

2. Install additional libraries (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_ADDITIONAL_LIBRARIES.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_ADDITIONAL_LIBRARIES.md)

## Usage

1. Run `shards install`
2. Run `crystal run`

## Fixture Example

```yaml
username: "admin"
email: "admin@noreaply.net"
password: "12345678"
active: true

---
username: "employee_1"
email: "employee_1_@noreaply.net"
password: "12345678"
active: false

---
username: "employee_2"
email: "employee_2_@noreaply.net"
password: "12345678"
active: false
```
