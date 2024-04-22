# app_name

An example of using Fixtures.
<br>
**Fixtures** - To populate the database with pre-created data.
<br>
**config/fixtures** - Directory for creating fixtures.

## Usage

1. Run `shards install`
2. Run `crystal run`

## Fixture Example

```yaml
url: "https://translate.google.com/"
text: "Some text"
phone: "+18004444444"
password: "12345678"
ip: "126.255.255.255"
hash2:
email: "john.smith@example.com"
color: "#ff0000"
slug:
date: "1970-01-01"
datetime: "1970-01-01T00:00:00"
choice_text: "value"
choice_text_mult: ["value"]
choice_text_dyn:
choice_text_mult_dyn:
choice_i64: 5
choice_i64_mult: [5]
choice_i64_dyn:
choice_i64_mult_dyn:
choice_f64: 5.0
choice_f64_mult: [5.0]
choice_f64_dyn:
choice_f64_mult_dyn:
file: "assets/media/default/no_doc.odt"
image: "assets/media/default/no_photo.jpeg"
i64: 10
f64: 10.2
bool:
```
