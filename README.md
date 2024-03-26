[![Logo](https://github.com/kebasyaty/dynfork/raw/v0/logo/logo.svg "Logo")](https://github.com/kebasyaty/dynfork "Logo")

# DynFork

ORM-like API MongoDB for Crystal language.
<br>
For simulate relationship Many-to-One and Many-to-Many,
<br>
a simplified alternative (Types of selective fields with dynamic addition of elements) is used.
<br>
The project is focused on web development.

[![CI](https://github.com/kebasyaty/dynfork/workflows/CI/badge.svg)](https://github.com/kebasyaty/dynfork/actions)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://kebasyaty.github.io/dynfork/)
[![Crystal](https://img.shields.io/badge/crystal-v1.10%2B-red)](https://crystal-lang.org/)
[![Github all releases](https://img.shields.io/github/downloads/kebasyaty/dynfork/total.svg)](https://GitHub.com/kebasyaty/dynfork/releases/)
[![GitHub license](https://badgen.net/github/license/kebasyaty/dynfork)](https://github.com/kebasyaty/dynfork/blob/v0/LICENSE)
<br>
<br>
_Compatible with MongoDB 3.6+. Tested against: 4.4, 6.0, 7.0._
<br>
_For more information see [Cryomongo](https://github.com/elbywan/cryomongo "Cryomongo")_.

<p>
  <a href="https://github.com/kebasyaty/dynfork" target="_blank">
    <img src="https://github.com/kebasyaty/dynfork/raw/v0/pictures/status_project/Status_Project-Development-.svg"
      alt="Status Project">
  </a>
</p>

## Documentation

Online browsable documentation is available at [https://kebasyaty.github.io/dynfork/](https://kebasyaty.github.io/dynfork/ "Documentation").

## Requirements

[View the list of requirements.](https://github.com/kebasyaty/dynfork/blob/v0/REQUIREMENTS.md "Requirements")

## Installation

1. Install MongoDB (if not installed):<br>
   Ubuntu - Follow the link [Ubuntu - Install MongoDB](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_INSTALL_MONGODB.md "Ubuntu - Install MongoDB").<br>
   Fedora - Follow the link [Fedora - Install MongoDB](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_INSTALL_MONGODB.md "Fedora - Install MongoDB").

2. Install additional libraries (if not installed):<br>
   Ubuntu - Follow the link [Ubuntu - Additional Libraries](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_ADDITIONAL_LIBRARIES.md "Additional Libraries").<br>
   Fedora - Follow the link [Fedora - Additional Libraries](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_ADDITIONAL_LIBRARIES.md "Fedora - Additional Libraries").

3. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     dynfork:
       github: kebasyaty/dynfork
   ```

4. Run `shards install`

## Usage

```crystal
require "i18n"
require "dynfork"

# Create your model.
@[DynFork::Meta(service_name: "Accounts")]
struct User < DynFork::Model
  getter username = DynFork::Fields::TextField.new
  getter email = DynFork::Fields::EmailField.new
  getter birthday = DynFork::Fields::DateField.new
end

# Initialize locale.
I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
I18n.config.default_locale = :en
I18n.init

# Run migration.
DynFork::Migration::Monitor.new(
  "app_name": "AppName",
  "unique_app_key": "k7SBQPF6d2e2nts7",
  "mongo_uri": "mongodb://localhost:27017",
  "model_list": {
      User,
  }
).migrat

# Create a user.
user = User.new

# Add user details.
user.username.value = "username"
user.email.value = "user@noreaply.net"
user.birthday.value = "2024-03-26"

# Save user.
# Hint: print_err - convenient for development.
user.print_err unless user.save?
```

## License

**This project is licensed under the** [MIT](https://github.com/kebasyaty/dynfork/blob/v0/LICENSE "MIT").

## Changelog

[View the change history.](https://github.com/kebasyaty/dynfork/blob/v0/CHANGELOG.md "Changelog")

## Contributing

1. Fork it (<https://github.com/kebasyaty/dynfork/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [kebasyaty](https://github.com/kebasyaty) Gennady Kostyunin - creator and maintainer
