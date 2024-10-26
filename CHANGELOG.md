#### v0.7.32 2024-10-26

- Parameter `warning` with `String` to `Array(String)`.
- Parameter `hint` with `Array(String)` to `String`.
- Updated README.md.
- Documentation updated.

#### v0.7.31 2024-10-25

- In the fields, the type of parameter `hint` with `String` to `Array(String)`.
- Updated README.md.
- Documentation updated.

#### v0.7.30 2024-10-16

- Fixed method `group_09`, added a check of the parameter `required`.
- Updated README.md.
- Documentation updated.

#### v0.7.29 2024-10-13

- For optimization, a variable `result_map_ptr` is removed.
- Updated README.md.
- Documentation updated.

#### v0.7.28 2024-10-13

- The methods are optimized: `document_to_hash`, `find_one_to_hash`, `find_one_to_instance`, `refrash_fields`, `find_one_to_json`, `find_one_and_delete`, `find_many_to_hash_list`, `find_many_to_json`.
- Updated README.md.
- Documentation updated.

#### v0.7.27 2024-10-09

- Updated locales.
- Updated README.md.
- Documentation updated.

#### v0.7.26 2024-10-06

- Updated `refrash_val_str` method for `DatField` and `DateTimeField` fields.
- Updated README.md.
- Documentation updated.

#### v0.7.25 2024-10-04

- Fixed `from_base64` and `from_path` methods for `FileField` and `ImageField` fields.
- Updated README.md.
- Documentation updated.

#### v0.7.24 2024-10-04

- Fixed `from_base64` and `from_path` methods for `FileField` and `ImageField` fields.
- Added property `extension` in `FileData`.
- Updated README.md.
- Documentation updated.

#### v0.7.23 2024-10-04

- Fixed `from_base64` and `from_path` methods for `FileField` and `ImageField` fields.
- Updated README.md.
- Documentation updated.

#### v0.7.22 2024-10-04

- Updated `from_base64` and `from_path` methods for `FileField` and `ImageField` fields.
- Updated README.md.
- Documentation updated.

#### v0.7.21 2024-10-02

- Fixed Model - Delete `@[JSON::Serializable::Options(emit_nulls: true)]`.
- Updated README.md.
- Documentation updated.

#### v0.7.20 2024-10-02

- Fixed Model - Added `@[JSON::Serializable::Options(emit_nulls: true)]`.
- Updated README.md.
- Documentation updated.

#### v0.7.19 2024-09-29

- Fixed comments for fields.
- Updated README.md.
- Documentation updated.

#### v0.7.18 2024-09-28

- Updated field parameters in the Model structure.
- Updated README.md.
- Documentation updated.

#### v0.7.17 2024-09-28

- Fixed serialization settings for field types.
- Updated README.md.
- Documentation updated.

#### v0.7.16 2024-09-25

- Added translations for fields.
- Updated README.md.
- Documentation updated.

#### v0.7.15 2024-09-24

- Added param `use_editor` in `TextField`.
- Updated README.md.
- Documentation updated.

#### v0.7.14 2024-09-02

- Updated README.md.
- Documentation updated.

#### v0.7.13 2024-08-10

- Removed unused alias `DataDynamicTypes`.
- Documentation updated.

#### v0.7.12 2024-08-09

- Fixed field comments.
- Documentation updated.

#### v0.7.11 2024-08-07

- Fixed fields - Added param `multiple`.
- Documentation updated.

#### v0.7.10 2024-07-27

- Updated .github/workflows/specs.yml
- Documentation updated.

#### v0.7.9 2024-06-22

- Documentation updated.

#### v0.7.8 2024-06-22

- Updated shard.yml.
- Documentation updated.

#### v0.7.7 2024-06-19

- Fix `OldPassNotMatch` exception.
- Documentation updated.

#### v0.7.6 2024-06-15

- Changed return types for `commons` methods.
- Documentation updated.

#### v0.7.5 2024-06-12

- Fixed shard.yml
- Documentation updated.

#### v0.7.4 2024-06-12

- Renamed method - object_id? in object_id.
- Documentation updated.

#### v0.7.3 2024-06-12

- Renamed method - verify_password? in verify_password.
- Documentation updated.

#### v0.7.2 2024-05-25

- Renamed the `assets` directory to `public`.
- An intermediate directory `uploads` has been added to the `media` directory.
- Documentation updated.

#### v0.7.1 2024-05-14

- Documentation updated.

#### v0.7.0 2024-05-13

- Financial methods have been added for the field type `F64Field`:
  - finance_plus
  - finance_minus
  - finance_divide
  - finance_multiply
- Documentation updated.

#### v0.6.2 2024-05-08

- Updated `.ameba.yml` file.
- Documentation updated.

#### v0.6.1 2024-05-07

- Fixed methods in the `QCommons` module.
- Documentation updated.

#### v0.6.0 2024-05-07

- Added `find_one_and_delete` mctode.
- Documentation updated.

#### v0.5.4 2024-05-03

- The `Model#object_id?` method has been optimized.
- The `HashField` field type has been optimized.
- Removed error type `InvalidHashString`.

#### v0.5.3 2024-05-02

- Added new error type `InvalidHashString`.
- Documentation updated.

#### v0.5.2 2024-05-02

- Documentation updated.
- Updated some comments in the source code.

#### v0.5.1 2024-05-02

- Documentation updated.
- Fixed some comments in the source code.

#### v0.5.0 2024-05-01

- Methods added: `delete_many`, `delete_one`, `bulk`, `bulk_write`.
- Renamed modules: `Paladins` to `QPaladins` and `Commons` to `QCommons`.
- Method comments have been updated.

#### v0.4.0 2024-05-01

- Changed the name and type of the variable in `DynFork::Migration::Monitor`.
- Update tests.
- Update examples.
- Updated README.md file.

#### v0.3.1 2024-04-30

- Updated README.md file.
- All README.md files in the examples have been updated.
- Documentation updated.

#### v0.3.0 2024-04-30

- Added a new exception `FailedGenerateUniqueID` for the `check` method.
- Renamed module `AA` to `Extra`.
- Corrected some comments.

#### v0.2.0 2024-04-29

- Added uniqueness check for `_id` in the `check` method. for a new document.
- Rename alias `ValueTypes` to `FieldValueTypes`

#### v0.1.3 2024-04-28

- `[]?` method removed from Model.
- Fixed tests for fields.
- Fixed comments for the `unit_manager` method.

#### v0.1.2 2024-04-28

- Update README.md.

#### v0.1.1 2024-04-28

- Update examples.

#### v0.1.0 2024-04-27

- The project has entered the **Beta** state.

#### v0.1.0 2023-10-16

- The repository is initialized.
