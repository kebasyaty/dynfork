module Crymon
  # Model parameters:
  # <br>
  # _( only **service_name** is a required parameter )_
  # <br>
  # <table>
  #   <tr>
  #     <th align="left">Parameter</th>
  #     <th align="left">Default</th>
  #     <th align="left">Description</th>
  #   </tr>
  #   <tr>
  #     <td align="left">service_name</td>
  #     <td align="left">no</td>
  #     <td align="left">**Examples:** Accounts | Smartphones | Washing machines | etc ... </td>
  #   </tr>
  #   <tr>
  #     <td align="left">fixture_name</td>
  #     <td align="left">no</td>
  #     <td align="left">**Examples:** SiteSettings | AppSettings | etc ... </td>
  #   </tr>
  #   <tr>
  #     <td align="left">db_query_docs_limit</td>
  #     <td align="left">1000</td>
  #     <td align="left">limiting query results.</td>
  #   </tr>
  #   <tr>
  #     <td align="left">is_saving_docs</td>
  #     <td align="left">true</td>
  #     <td align="left">Create documents in the database. **false** - Alternatively, use it to validate data from web forms.</td>
  #   </tr>
  #   <tr>
  #     <td align="left">is_updating_docs</td>
  #     <td align="left">true</td>
  #     <td align="left">Update documents in the database.</td>
  #   </tr>
  #   <tr>
  #     <td align="left">is_deleting_docs</td>
  #     <td align="left">true</td>
  #     <td align="left">Delete documents from the database.</td>
  #   </tr>
  # </table>
  #
  # Example:
  # ```
  # @[Crymon::Meta(service_name: "Accounts")]
  # struct User < Crymon::Model
  #   getter username = Crymon::Fields::TextField.new
  #   getter birthday = Crymon::Fields::DateField.new
  # end
  # ```
  #
  annotation Meta; end
end
