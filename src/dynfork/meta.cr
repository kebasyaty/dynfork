module DynFork
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
  #     <td align="left"><b>Examples:</b> Accounts | Smartphones | Washing machines | etc... </td>
  #   </tr>
  #   <tr>
  #     <td align="left">fixture_name</td>
  #     <td align="left">no</td>
  #     <td align="left">
  #       The name of the fixture in the <b>config/fixtures</b> directory (without extension).
  #       <br>
  #       <b>Examples:</b> SiteSettings | AppSettings | etc ...
  #     </td>
  #   </tr>
  #   <tr>
  #     <td align="left">db_query_docs_limit</td>
  #     <td align="left">1000</td>
  #     <td align="left">limiting query results.</td>
  #   </tr>
  #   <tr>
  #     <td align="left">saving_docs?</td>
  #     <td align="left">true</td>
  #     <td align="left">
  #       Create documents in the database.<br>
  #       If <b>false</b> - Alternatively,
  #       use it to validate data from web forms (search form, contact form, etc...).
  #     </td>
  #   </tr>
  #   <tr>
  #     <td align="left">updating_docs?</td>
  #     <td align="left">true</td>
  #     <td align="left">Update documents in the database.</td>
  #   </tr>
  #   <tr>
  #     <td align="left">deleting_docs?</td>
  #     <td align="left">true</td>
  #     <td align="left">Delete documents from the database.</td>
  #   </tr>
  # </table>
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  # ```
  #
  annotation Meta; end
end
