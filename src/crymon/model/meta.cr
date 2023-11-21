module Crymon
  # **Model parameters**
  # <br>
  # _( only service_name is a required parameter )_
  # <br>
  # | Parameter:          | Default:     | Description:                                                                                         |
  # | :------------------ | :----------- | :--------------------------------------------------------------------------------------------------- |
  # | service_name        | no           | **Examples:** Accounts | Smartphones | Washing machines | etc ...                                    |                                        |
  # | db_query_docs_limit | 1000         | limiting query results.                                                                              |
  # | is_add_doc          | true         | Create documents in the database. **false** - Alternatively, use it to validate data from web forms. |
  # | is_up_doc           | true         | Update documents in the database.                                                                    |
  # | is_del_doc          | true         | Delete documents from the database.                                                                  |
  #
  annotation Meta; end
end
