# app_name

An example of a fixture with several documents.
<br>
**Fixtures** - To populate the database with pre-created data.
<br>
**config/fixtures** - Directory for creating fixtures.

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
