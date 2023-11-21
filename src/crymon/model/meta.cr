module Crymon
  # To pass metadata to Model.
  # <br>
  # **Model parameters**
  # <br>
  # _( all parameters are optional )_
  # <br>
  # | Parameter:          | Default:     | Description:                                                                                         |
  # | :------------------ | :----------- | :--------------------------------------------------------------------------------------------------- |
  # | service_name        | 1000         | Examples: Accounts | Smartphones | Washing machines | etc ...                                                                            |
  # | db_query_docs_limit | 1000         | limiting query results.                                                                              |
  # | is_add_doc          | true         | Create documents in the database. **false** - Alternatively, use it to validate data from web forms. |
  # | is_up_doc           | true         | Update documents in the database.                                                                    |
  # | is_del_doc          | true         | Delete documents from the database.                                                                  |
  # | ignore_fields       | empty string | Fields that are not included in the database (separated by commas).                                  |
  # | is_use_addition     | false        | Allows methods for additional actions and additional validation.                                     |
  # | is_use_hooks        | false        | Allows hooks methods - **impl Hooks for ModelName**.                                                 |
  #
  annotation Meta; end
end
