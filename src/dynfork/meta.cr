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
  #     <td align="left">migrat_model?</td>
  #     <td align="left">true</td>
  #     <td align="left">
  #       Set to <b>false</b> if you do not need to migrate the Model to the database.<br>
  #       This can be use to validate a web forms - Search form, Contact form, etc.
  #     </td>
  #   </tr>
  #   <tr>
  #     <td align="left">create_doc?</td>
  #     <td align="left">true</td>
  #     <td align="left">
  #       Can a Model create new documents in a collection?<br>
  #       Set to <b>false</b> if you only need one document in the collection and the Model is using a fixture.
  #     </td>
  #   </tr>
  #   <tr>
  #     <td align="left">update_doc?</td>
  #     <td align="left">true</td>
  #     <td align="left">Can a Model update documents in a collection?</td>
  #   </tr>
  #   <tr>
  #     <td align="left">delete_doc?</td>
  #     <td align="left">true</td>
  #     <td align="left">Can a Model remove documents from a collection?</td>
  #   </tr>
  # </table>
  #
  # Example:
  # ```
  # @[DynFork::Meta(
  #   service_name: "ServiceName",
  #   fixture_name: "FixtureName",
  #   db_query_docs_limit: 1000,
  #   migrat_model?: true,
  #   create_doc?: true,
  #   update_doc?: true,
  #   delete_doc?: true,
  # )]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  # ```
  #
  annotation Meta; end
end
