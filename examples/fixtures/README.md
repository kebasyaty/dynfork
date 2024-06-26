# app_name

An example of using Fixtures.
<br>
**Fixtures** - To populate the database with pre-created data.
<br>
**config/fixtures** - Directory for creating fixtures.

## Installation

1. Install MongoDB (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_INSTALL_MONGODB.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-ba4319?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_INSTALL_MONGODB.md)
   [![Linux Mint](https://img.shields.io/badge/Linux_Mint-5e902b?style=for-the-badge&logo=linux-mint&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_INSTALL_MONGODB.md)

2. Install additional libraries (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_ADDITIONAL_LIBRARIES.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-ba4319?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_ADDITIONAL_LIBRARIES.md)
   [![Linux Mint](https://img.shields.io/badge/Linux_Mint-5e902b?style=for-the-badge&logo=linux-mint&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_ADDITIONAL_LIBRARIES.md)

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
file: "public/media/default/no_doc.odt"
image: "public/media/default/no_photo.jpeg"
i64: 10
f64: 10.2
bool:
```
