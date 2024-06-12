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
