<br>
<br>
<div align="center">
  <p align="center">
    <a href="https://github.com/kebasyaty/dynfork">
      <img
        alt="Logo"
        src="https://github.com/kebasyaty/dynfork/raw/main/logo/logo.svg">
    </a>
  </p>
  <p>
    <h1>DynFork</h1>
    <h3>ORM-like API MongoDB for Crystal language.</h3>
    <p align="center">
      <a href="https://github.com/kebasyaty/dynfork/actions" alt="CI"><img src="https://github.com/kebasyaty/dynfork/workflows/CI/badge.svg" alt="CI"></a>
      <a href="https://kebasyaty.github.io/dynfork/" alt="Docs"><img src="https://img.shields.io/badge/docs-available-brightgreen.svg" alt="Docs"></a>
      <a href="https://crystal-lang.org/" alt="Crysta"><img src="https://img.shields.io/badge/crystal-v1.11%2B-CC342D" alt="Crysta"></a>
      <a href="https://github.com/kebasyaty/dynfork/releases/" alt="GitHub release"><img src="https://img.shields.io/github/release/kebasyaty/dynfork" alt="GitHub release"></a>
      <a href="https://github.com/kebasyaty/dynfork/blob/main/LICENSE" alt="GitHub license"><img src="https://badgen.net/github/license/kebasyaty/dynfork" alt="GitHub license"></a>
      <a href="https://github.com/kebasyaty/dynfork" alt="GitHub repository"><img src="https://img.shields.io/badge/--ecebeb?logo=github&logoColor=000000" alt="GitHub repository"></a>
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
  <a href="https://github.com/kebasyaty/dynfork" alt="Status Project">
    <img src="https://github.com/kebasyaty/dynfork/raw/main/pictures/status_project/Status_Project-Beta-.svg"
      alt="Status Project">
  </a>
</p>

## Documentation

Online browsable documentation is available at [https://kebasyaty.github.io/dynfork/](https://kebasyaty.github.io/dynfork/ "Documentation").

## Requirements

[View the list of requirements.](https://github.com/kebasyaty/dynfork/blob/main/REQUIREMENTS.md "View the list of requirements.")

## Installation

1. Install MongoDB (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_INSTALL_MONGODB.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-ba4319?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_INSTALL_MONGODB.md)
   [![Linux Mint](https://img.shields.io/badge/Linux_Mint-5e902b?style=for-the-badge&logo=linux-mint&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_INSTALL_MONGODB.md)

2. Install additional libraries (if not installed):<br>
   [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/FEDORA_ADDITIONAL_LIBRARIES.md)
   [![Ubuntu](https://img.shields.io/badge/Ubuntu-ba4319?style=for-the-badge&logo=ubuntu&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_ADDITIONAL_LIBRARIES.md)
   [![Linux Mint](https://img.shields.io/badge/Linux_Mint-5e902b?style=for-the-badge&logo=linux-mint&logoColor=white)](https://github.com/kebasyaty/dynfork/blob/main/UBUNTU_ADDITIONAL_LIBRARIES.md)

3. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     dynfork:
       github: kebasyaty/dynfork
       version: ~> 0.6.0
   ```

4. Run `shards install`

## Usage

It is recommended to look at examples [here](https://github.com/kebasyaty/dynfork/tree/main/examples "here").

```crystal
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
# https://elbywan.github.io/cryomongo/Mongo/Client.html
DynFork::Migration::Monitor.new(
  app_name: "AppName",
  unique_app_key: "Towr5kKQM5H3Lb0b",
  mongo_client: Mongo::Client.new("mongodb://localhost:27017")
).migrat

# Create a user.
user = User.new

# Add user data.
user.username.value = "username"
user.email.value = "user@noreaply.net"
user.birthday.value = "1970-01-01"

# Save user.
# Hint: print_err - convenient for development.
user.print_err unless user.save

# Print user details.
puts "User details:"
if id = user.object_id?
  pp User.find_one_to_hash({_id: id})
end

puts "Documwnt count: #{User.estimated_document_count}"

puts "Deleting a document."
user.delete

puts "Documwnt count: #{User.count_documents}"
```

### [See more examples here.](https://github.com/kebasyaty/dynfork/tree/main/examples "See more examples here.")

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
       <td align="left">migrat_model?</td>
       <td align="left">true</td>
       <td align="left">
         Set to <b>false</b> if you do not need to migrate the Model to the database.<br>
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

## Methods for developers

_Links to documentation._

**[Model:](https://kebasyaty.github.io/dynfork/DynFork/Model.html "Model:")**

- full_model_name
- meta
- subclasses
- object_id?

**[Extra:](https://kebasyaty.github.io/dynfork/DynFork/Extra.html "Extra:")**

- add_validation
- indexing
- pre_create
- post_create
- pre_update
- post_update
- pre_delete
- post_delete

**[Migration:](https://kebasyaty.github.io/dynfork/DynFork/Migration.html "Migration:")**

- migrat

**[QPaladins:](https://kebasyaty.github.io/dynfork/DynFork/QPaladins.html "QPaladins:")**

- valid?
- save
- print_err
- delete
- verify_password?
- update_password

**[QCommons:](https://kebasyaty.github.io/dynfork/DynFork/QCommons.html "QCommons:")**

- aggregate
- collection_name
- count_documents
- distinct
- estimated_document_count
- stats
- find_many_to_hash_list
- find_many_to_json
- find_one_to_hash
- find_one_to_instance
- find_one_to_json
- find_one_and_delete
- unit_manager
- delete_many
- delete_one
- bulk
- bulk_write
- create_index
- create_indexes
- drop_index
- drop_indexes
- list_indexes

## License

**This project is licensed under the** [MIT](https://github.com/kebasyaty/dynfork/blob/main/LICENSE "MIT").

## Changelog

[View the change history.](https://github.com/kebasyaty/dynfork/blob/main/CHANGELOG.md "Changelog")

## Contributing

1. Fork it (<https://github.com/kebasyaty/dynfork/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [kebasyaty](https://github.com/kebasyaty) Gennady Kostyunin - creator and maintainer

<br>
<br>
<div>
  <a href="https://crystal-lang.org/" alt="Made with Crystal">
    <img width="100%" src="https://github.com/kebasyaty/dynfork/raw/main/pictures/made-with-crystal.svg"
      alt="Made with Crystal">
  </a>
</div>
