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
      <a href="https://github.com/kebasyaty/dynfork/blob/v0/LICENSE-APACHE" alt="Apache Version 2.0"><img src="https://img.shields.io/badge/License-Apache_2.0-yellowgreen.svg" alt="Apache Version 2.0"></a>
      <a href="https://github.com/kebasyaty/dynfork/blob/v0/LICENSE-MIT" alt="MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT"></a>
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
    <img src="https://github.com/kebasyaty/dynfork/raw/v0/pictures/status_project/Status_Project-Beta-.svg"
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
).migrat

# Create a user.
user = User.new

# Add user details.
user.username.value = "username"
user.email.value = "user@noreaply.net"
user.birthday.value = "1970-01-01"

# Run save.
# Hint: print_err - convenient for development.
user.print_err unless user.save

# Print user details.
puts "User details:"
user_list = User.find_many_to_hash_list
pp user_list

puts "Documwnt count: #{User.estimated_document_count}"

puts "Deleting a document."
user.delete

puts "Documwnt count: #{User.count_documents}"
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

**Additional validation:**<br>
[add_validation](https://kebasyaty.github.io/dynfork/DynFork/AA.html#add_validation%3AHash%28String%2CString%29-instance-method "add_validation")

**Indexing:**<br>
[indexing](https://kebasyaty.github.io/dynfork/DynFork/AA.html#indexing%3ANil-class-method "indexing")

**Hooks:**<br>
[pre_create](https://kebasyaty.github.io/dynfork/DynFork/AA.html#pre_create%3ANil-instance-method "pre_create")<br>
[post_create](https://kebasyaty.github.io/dynfork/DynFork/AA.html#post_create%3ANil-instance-method "post_create")<br>
[pre_update](https://kebasyaty.github.io/dynfork/DynFork/AA.html#pre_update%3ANil-instance-method "pre_update")<br>
[post_update](https://kebasyaty.github.io/dynfork/DynFork/AA.html#post_update%3ANil-instance-method "post_update")<br>
[pre_delete](https://kebasyaty.github.io/dynfork/DynFork/AA.html#pre_delete%3ANil-instance-method "pre_delete")<br>
[post_delete](https://kebasyaty.github.io/dynfork/DynFork/AA.html#post_delete%3ANil-instance-method "post_delete")

**Migration:**<br>
[migrat](https://kebasyaty.github.io/dynfork/DynFork/Migration/Monitor.html#migrat%3ANil-instance-method "migrat")

**Model:**<br>
[full_model_name](https://kebasyaty.github.io/dynfork/DynFork/Model.html#full_model_name%3AString-class-method "full_model_name")<br>
[meta](https://kebasyaty.github.io/dynfork/DynFork/Model.html#meta%3ADynFork%3A%3AGlobals%3A%3ACacheMetaDataType%7CNil-class-method "meta")<br>
[subclasses](https://kebasyaty.github.io/dynfork/DynFork/Model.html#subclasses-class-method "subclasses")<br>
[object_id?](https://kebasyaty.github.io/dynfork/DynFork/Model.html#object_id%3F%3ABSON%3A%3AObjectId%7CNil-instance-method "object_id?")

**Paladins:**<br>
[valid?](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Tools.html#valid%3F%3ABool-instance-method "valid?")<br>
[save](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Save.html "save")<br>
[print_err](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Tools.html#print_err%3ANil-instance-method "print_err")<br>
[delete](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Tools.html#delete%3ANil-instance-method "delete")<br>
[verify_password?](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Password.html#verify_password%3F%28password%3AString%2Cfield_name%3AString%3D%22password%22%29%3ABool-instance-method "verify_password?")<br>
[update_password](https://kebasyaty.github.io/dynfork/DynFork/Paladins/Password.html#update_password%28old_password%3AString%2Cnew_password%3AString%2Cfield_name%3AString%3D%22password%22%29%3ANil-instance-method "update_password")

**Commons:**<br>
[aggregate](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#aggregate%28pipeline%3AArray%2C%2A%2Callow_disk_use%3ABool%7CNil%3Dnil%2Cbatch_size%3AInt32%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cbypass_document_validation%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cwrite_concern%3AMongo%3A%3AWriteConcern%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AMongo%3A%3ACursor%7CNil-instance-method "aggregate")<br>
[collection_name](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#collection_name%3AMongo%3A%3ACollection%3A%3ACollectionKey-instance-method "collection_name")<br>
[count_documents](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#count_documents%28filter%3DBSON.new%2C%2A%2Cskip%3AInt32%7CNil%3Dnil%2Climit%3AInt32%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AInt32-instance-method "count_documents")<br>
[distinct](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#distinct%28key%3AString%2C%2A%2Cfilter%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AArray-instance-method "distinct")<br>
[estimated_document_count](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#estimated_document_count%28%2A%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AInt32-instance-method "estimated_document_count")<br>
[stats](https://kebasyaty.github.io/dynfork/DynFork/Commons/QGeneral.html#stats%28%2A%2Cscale%3AInt32%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3ABSON%7CNil-instance-method "stats")<br>
[find_many_to_hash_list](https://kebasyaty.github.io/dynfork/DynFork/Commons/QMany.html#find_many_to_hash_list%28filter%3DBSON.new%2C%2A%2Csort%3Dnil%2Cprojection%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cskip%3AInt32%7CNil%3Dnil%2Climit%3AInt32%7CNil%3Dnil%2Cbatch_size%3AInt32%7CNil%3Dnil%2Csingle_batch%3ABool%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cmax%3Dnil%2Cmin%3Dnil%2Creturn_key%3ABool%7CNil%3Dnil%2Cshow_record_id%3ABool%7CNil%3Dnil%2Ctailable%3ABool%7CNil%3Dnil%2Coplog_replay%3ABool%7CNil%3Dnil%2Cno_cursor_timeout%3ABool%7CNil%3Dnil%2Cawait_data%3ABool%7CNil%3Dnil%2Callow_partial_results%3ABool%7CNil%3Dnil%2Callow_disk_use%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AArray%28Hash%28String%2CDynFork%3A%3AGlobals%3A%3AValueTypes%29%29-instance-method "find_many_to_hash_list")<br>
[find_many_to_json](https://kebasyaty.github.io/dynfork/DynFork/Commons/QMany.html#find_many_to_json%28filter%3DBSON.new%2C%2A%2Csort%3Dnil%2Cprojection%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cskip%3AInt32%7CNil%3Dnil%2Climit%3AInt32%7CNil%3Dnil%2Cbatch_size%3AInt32%7CNil%3Dnil%2Csingle_batch%3ABool%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cmax%3Dnil%2Cmin%3Dnil%2Creturn_key%3ABool%7CNil%3Dnil%2Cshow_record_id%3ABool%7CNil%3Dnil%2Ctailable%3ABool%7CNil%3Dnil%2Coplog_replay%3ABool%7CNil%3Dnil%2Cno_cursor_timeout%3ABool%7CNil%3Dnil%2Cawait_data%3ABool%7CNil%3Dnil%2Callow_partial_results%3ABool%7CNil%3Dnil%2Callow_disk_use%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AString-instance-method "find_many_to_json")<br>
[find_one_to_hash](https://kebasyaty.github.io/dynfork/DynFork/Commons/QOne.html#find_one_to_hash%28filter%3DBSON.new%2C%2A%2Csort%3Dnil%2Cprojection%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cskip%3AInt32%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cmax%3Dnil%2Cmin%3Dnil%2Creturn_key%3ABool%7CNil%3Dnil%2Cshow_record_id%3ABool%7CNil%3Dnil%2Coplog_replay%3ABool%7CNil%3Dnil%2Cno_cursor_timeout%3ABool%7CNil%3Dnil%2Callow_partial_results%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AHash%28String%2CDynFork%3A%3AGlobals%3A%3AValueTypes%29%7CNil-instance-method "find_one_to_hash")<br>
[find_one_to_instance](https://kebasyaty.github.io/dynfork/DynFork/Commons/QOne.html#find_one_to_instance%28filter%3DBSON.new%2C%2A%2Csort%3Dnil%2Cprojection%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cskip%3AInt32%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cmax%3Dnil%2Cmin%3Dnil%2Creturn_key%3ABool%7CNil%3Dnil%2Cshow_record_id%3ABool%7CNil%3Dnil%2Coplog_replay%3ABool%7CNil%3Dnil%2Cno_cursor_timeout%3ABool%7CNil%3Dnil%2Callow_partial_results%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3Aself%7CNil-instance-method "find_one_to_instance")<br>
[find_one_to_json](https://kebasyaty.github.io/dynfork/DynFork/Commons/QOne.html#find_one_to_json%28filter%3DBSON.new%2C%2A%2Csort%3Dnil%2Cprojection%3Dnil%2Chint%3AString%7CHash%7CNamedTuple%7CNil%3Dnil%2Cskip%3AInt32%7CNil%3Dnil%2Ccomment%3AString%7CNil%3Dnil%2Cmax_time_ms%3AInt64%7CNil%3Dnil%2Cread_concern%3AMongo%3A%3AReadConcern%7CNil%3Dnil%2Cmax%3Dnil%2Cmin%3Dnil%2Creturn_key%3ABool%7CNil%3Dnil%2Cshow_record_id%3ABool%7CNil%3Dnil%2Coplog_replay%3ABool%7CNil%3Dnil%2Cno_cursor_timeout%3ABool%7CNil%3Dnil%2Callow_partial_results%3ABool%7CNil%3Dnil%2Ccollation%3AMongo%3A%3ACollation%7CNil%3Dnil%2Cread_preference%3AMongo%3A%3AReadPreference%7CNil%3Dnil%2Csession%3AMongo%3A%3ASession%3A%3AClientSession%7CNil%3Dnil%29%3AString-instance-method "find_one_to_json")<br>
[unit_manager](https://kebasyaty.github.io/dynfork/DynFork/Commons/UnitsManagement.html#unit_manager%28unit%3ADynFork%3A%3AGlobals%3A%3AUnit%29%3ANil-instance-method "unit_manager")

## License

**This project is licensed under the** [Apache Version 2.0](https://github.com/kebasyaty/dynfork/blob/v0/LICENSE-APACHE "Apache Version 2.0") and [MIT](https://github.com/kebasyaty/dynfork/blob/v0/LICENSE-MIT "MIT")

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
