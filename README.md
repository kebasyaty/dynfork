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
   **Ubuntu** - Follow the link [Ubuntu - Install MongoDB](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_INSTALL_MONGODB.md "Ubuntu - Install MongoDB").<br>
   **Fedora** - Follow the link [Fedora - Install MongoDB](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_INSTALL_MONGODB.md "Fedora - Install MongoDB").

2. Install additional libraries (if not installed):<br>
   **Ubuntu** - Follow the link [Ubuntu - Additional Libraries](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_ADDITIONAL_LIBRARIES.md "Additional Libraries").<br>
   **Fedora** - Follow the link [Fedora - Additional Libraries](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_ADDITIONAL_LIBRARIES.md "Fedora - Additional Libraries").

3. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     dynfork:
       github: kebasyaty/dynfork
   ```

4. Run `shards install`

## Usage

It is recommended to look at examples [here](https://github.com/kebasyaty/dynfork/tree/v0/examples "here").

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

# Print user details.
puts "# New user details:"
puts "hash: #{user.hash.value?}"
puts "username: #{user.username.value?}"
puts "email: #{user.email.value?}"
puts "birthday: #{user.birthday.value?}"
puts "created_at: #{user.created_at.value?}"
puts "updated_at: #{user.updated_at.value?}"
```

### [See more examples here.](https://github.com/kebasyaty/dynfork/tree/v0/examples "See more examples here.")

## Model Parameters

###### only `service_name` is a required parameter

See the documentation [here](https://kebasyaty.github.io/dynfork/DynFork/Meta.html "here").

<div>
   <table>
     <tr>
       <th align="left">Parameter</th>
       <th align="left">Default</th>
       <th align="left">Description</th>
     </tr>
     <tr>
       <td align="left">service_name</td>
       <td align="left">no</td>
       <td align="left"><b>Examples:</b> Accounts | Smartphones | Washing machines | etc ... </td>
     </tr>
     <tr>
       <td align="left">fixture_name</td>
       <td align="left">no</td>
       <td align="left">
         The name of the fixture in the <b>config/fixtures</b> directory (without extension).
         <br>
         <b>Examples:</b> SiteSettings | AppSettings | etc ...
       </td>
     </tr>
     <tr>
       <td align="left">db_query_docs_limit</td>
       <td align="left">1000</td>
       <td align="left">limiting query results.</td>
     </tr>
     <tr>
       <td align="left">saving_docs?</td>
       <td align="left">true</td>
       <td align="left">Create documents in the database. <b>false</b> - Alternatively, use it to validate data from web forms.</td>
     </tr>
     <tr>
       <td align="left">updating_docs?</td>
       <td align="left">true</td>
       <td align="left">Update documents in the database.</td>
     </tr>
     <tr>
       <td align="left">deleting_docs?</td>
       <td align="left">true</td>
       <td align="left">Delete documents from the database.</td>
     </tr>
   </table>
</div>

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
