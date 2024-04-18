<div align="center">
  <p align="center">
    <a href="https://github.com/kebasyaty/dynfork" target="_blank">
      <img
        height="120"
        alt="Logo"
        src="https://github.com/kebasyaty/dynfork/raw/v0/logo/logo.svg">
    </a>
  </p>
  <p>
    <h1>DynFork</h1>
    <h3>ORM-like API MongoDB for Crystal language.</h3>
    <p align="center">
      <a href="https://github.com/kebasyaty/dynfork/actions" alt="CI"><img src="https://github.com/kebasyaty/dynfork/workflows/CI/badge.svg" alt="CI"></a>
      <a href="https://kebasyaty.github.io/dynfork/" alt="Docs"><img src="https://img.shields.io/badge/docs-available-brightgreen.svg" alt="Docs"></a>
      <a href="https://crystal-lang.org/" alt="Crysta"><img src="https://img.shields.io/badge/crystal-v1.10%2B-red"></a>
      <a href="https://github.com/kebasyaty/dynfork/blob/v0/LICENSE" alt="GitHub license"><img src="https://badgen.net/github/license/kebasyaty/dynfork" alt="GitHub license"></a>
      <a href="https://github.com/kebasyaty/dynfork" alt="GitHub"><img src="https://badgen.net/badge/icon/github?icon=github&label" alt="GitHub"></a>
    </p>
    <div align="center">
      DynFork is built around <a href="https://github.com/elbywan/cryomongo" alt="Cryomongo">Cryomongo</a> and is more focused on web development.
      <br>
      For simulate relationship Many-to-One and Many-to-Many,
      <br>
      a simplified alternative (Types of selective fields with dynamic addition of elements) is used.
      <br>
      The project is focused on web development.
    </div>
  </p>
</div>

<hr>

_Compatible with MongoDB 3.6+. Tested against: 4.4, 6.0, 7.0._
<br>
_For more information see [Cryomongo](https://github.com/elbywan/cryomongo "Cryomongo")_.

<p>
  <a href="https://github.com/kebasyaty/dynfork" alt="Status Project" target="_blank">
    <img src="https://github.com/kebasyaty/dynfork/raw/v0/pictures/status_project/Status_Project-Alpha-.svg"
      alt="Status Project">
  </a>
</p>

## Documentation

Online browsable documentation is available at [https://kebasyaty.github.io/dynfork/](https://kebasyaty.github.io/dynfork/ "Documentation").

## Requirements

[View the list of requirements.](https://github.com/kebasyaty/dynfork/blob/v0/REQUIREMENTS.md "View the list of requirements.")

## Installation

1. Install MongoDB (if not installed):<br>
   [Ubuntu](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_INSTALL_MONGODB.md "Ubuntu").<br>
   [Fedora](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_INSTALL_MONGODB.md "Fedora").

2. Install additional libraries (if not installed):<br>
   [Ubuntu](https://github.com/kebasyaty/dynfork/blob/v0/UBUNTU_ADDITIONAL_LIBRARIES.md "Ubuntu").<br>
   [Fedora](https://github.com/kebasyaty/dynfork/blob/v0/FEDORA_ADDITIONAL_LIBRARIES.md "Fedora").

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
# https://github.com/crystal-i18n/i18n
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

# Run save.
# Hint: print_err - convenient for development.
user.print_err unless user.save

# Print user details.
puts "# New user details:"
puts "hash: #{user.hash.value?}"
puts "username: #{user.username.value?}"
puts "email: #{user.email.value?}"
puts "birthday: #{user.birthday.value?}"
puts "created_at: #{user.created_at.value?}"
puts "updated_at: #{user.updated_at.value?}"

puts "\nNumber of documents: #{User.estimated_document_count}"

puts "Deleting a document."
user.delete

puts "Number of documents: #{User.count_documents}"
```

### [See more examples here.](https://github.com/kebasyaty/dynfork/tree/v0/examples "See more examples here.")

## Model Parameters

See the documentation [here](https://kebasyaty.github.io/dynfork/DynFork/Meta.html "here").

###### only `service_name` is a required parameter

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
       <td align="left"><b>Examples:</b> Accounts | Smartphones | Washing machines | etc... </td>
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
       <td align="left">migrat_model?</td>
       <td align="left">true</td>
       <td align="left">
         Set to <b>false</b> if you do not need to migrate the model to the database.<br>
         This can be use to validate a web forms - Search form, Contact form, etc.
       </td>
     </tr>
     <tr>
       <td align="left">create_doc?</td>
       <td align="left">true</td>
       <td align="left">
         Can a Model create new documents in a collection?<br>
         Set to <b>false</b> if you only need one document in the collection and the Model is using a fixture.
       </td>
     </tr>
     <tr>
       <td align="left">update_doc?</td>
       <td align="left">true</td>
       <td align="left">Can a Model update documents in a collection?</td>
     </tr>
     <tr>
       <td align="left">delete_doc?</td>
       <td align="left">true</td>
       <td align="left">Can a Model remove documents from a collection?</td>
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
