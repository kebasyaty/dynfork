module Crymon
  # Model parameters:
  # <br>
  # _( only **service_name** is a required parameter )_
  # <br>
  # <table>
  #   <tr>
  #     <th>Parameter</th>
  #     <th>Default</th>
  #     <th>Description</th>
  #   </tr>
  #   <tr>
  #     <td>service_name</td>
  #     <td>no</td>
  #     <td>**Examples:** Accounts | Smartphones | Washing machines | etc ... </td>
  #   </tr>
  #   <tr>
  #     <td>db_query_docs_limit</td>
  #     <td>1000</td>
  #     <td>limiting query results.</td>
  #   </tr>
  #   <tr>
  #     <td>is_add_doc</td>
  #     <td>true</td>
  #     <td>Create documents in the database. **false** - Alternatively, use it to validate data from web forms.</td>
  #   </tr>
  #   <tr>
  #     <td>is_up_doc </td>
  #     <td>true</td>
  #     <td>Update documents in the database.</td>
  #   </tr>
  #   <tr>
  #     <td>is_del_doc</td>
  #     <td>true</td>
  #     <td>Delete documents from the database.</td>
  #   </tr>
  # </table>
  annotation Meta; end
end
