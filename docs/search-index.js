crystal_doc_search_index_callback({"repository_name":"cryode","body":"[![Logo](https://github.com/kebasyaty/cryode/raw/v0/logo/logo.svg \"Logo\")](https://github.com/kebasyaty/cryode \"Logo\")\r\n\r\nORM-like API MongoDB for Crystal\r\n\r\n[![CI](https://github.com/kebasyaty/cryode/workflows/CI/badge.svg)](https://github.com/kebasyaty/cryode/actions)\r\n[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://kebasyaty.github.io/cryode/)\r\n[![Crystal](https://img.shields.io/badge/crystal-v1.10%2B-red)](https://crystal-lang.org/)\r\n[![GitHub license](https://badgen.net/github/license/kebasyaty/cryode)](https://github.com/kebasyaty/cryode/blob/v0/LICENSE)\r\n\r\n## Installation\r\n\r\n1. Add the dependency to your `shard.yml`:\r\n\r\n   ```yaml\r\n   dependencies:\r\n     cryode:\r\n       github: kebasyaty/cryode\r\n   ```\r\n\r\n2. Run `shards install`\r\n\r\n## Usage\r\n\r\n```crystal\r\nrequire \"cryode\"\r\n```\r\n\r\nTODO: Write usage instructions here\r\n\r\n## Development\r\n\r\nTODO: Write development instructions here\r\n\r\n## License\r\n\r\n**This project is licensed under the** [MIT](https://github.com/kebasyaty/cryode/blob/v0/LICENSE \"MIT\").\r\n\r\n## Changelog\r\n\r\n[View the change history.](https://github.com/kebasyaty/cryode/blob/v0/CHANGELOG.md \"View the change history.\")\r\n\r\n## Contributing\r\n\r\n1. Fork it (<https://github.com/kebasyaty/cryode/fork>)\r\n2. Create your feature branch (`git checkout -b my-new-feature`)\r\n3. Commit your changes (`git commit -am 'Add some feature'`)\r\n4. Push to the branch (`git push origin my-new-feature`)\r\n5. Create a new Pull Request\r\n\r\n## Contributors\r\n\r\n- [kebasyaty](https://github.com/kebasyaty) Gennady Kostyunin - creator and maintainer\r\n","program":{"html_id":"cryode/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"locations":[],"repository_name":"cryode","program":true,"enum":false,"alias":false,"const":false,"types":[{"html_id":"cryode/Cryode","path":"Cryode.html","kind":"module","full_name":"Cryode","name":"Cryode","abstract":false,"locations":[{"filename":"src\\cryode.cr","line_number":4,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode.cr#L4"},{"filename":"src\\cryode\\errors.cr","line_number":2,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\errors.cr#L2"},{"filename":"src\\cryode\\fields\\bool.cr","line_number":3,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\fields\\bool.cr#L3"}],"repository_name":"cryode","program":false,"enum":false,"alias":false,"const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"\"0.1.0\""}],"doc":"ORM-like API MongoDB for Crystal","summary":"<p>ORM-like API MongoDB for Crystal</p>","types":[{"html_id":"cryode/Cryode/CryodeException","path":"Cryode/CryodeException.html","kind":"class","full_name":"Cryode::CryodeException","name":"CryodeException","abstract":false,"superclass":{"html_id":"cryode/Exception","kind":"class","full_name":"Exception","name":"Exception"},"ancestors":[{"html_id":"cryode/Exception","kind":"class","full_name":"Exception","name":"Exception"},{"html_id":"cryode/Reference","kind":"class","full_name":"Reference","name":"Reference"},{"html_id":"cryode/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src\\cryode\\errors.cr","line_number":3,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\errors.cr#L3"}],"repository_name":"cryode","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"cryode/Cryode","kind":"module","full_name":"Cryode","name":"Cryode"}},{"html_id":"cryode/Cryode/Fields","path":"Cryode/Fields.html","kind":"module","full_name":"Cryode::Fields","name":"Fields","abstract":false,"locations":[{"filename":"src\\cryode\\fields\\bool.cr","line_number":4,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\fields\\bool.cr#L4"}],"repository_name":"cryode","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"cryode/Cryode","kind":"module","full_name":"Cryode","name":"Cryode"},"types":[{"html_id":"cryode/Cryode/Fields/BoolField","path":"Cryode/Fields/BoolField.html","kind":"struct","full_name":"Cryode::Fields::BoolField","name":"BoolField","abstract":false,"superclass":{"html_id":"cryode/Struct","kind":"struct","full_name":"Struct","name":"Struct"},"ancestors":[{"html_id":"cryode/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"cryode/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"cryode/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[{"filename":"src\\cryode\\fields\\bool.cr","line_number":5,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\fields\\bool.cr#L5"}],"repository_name":"cryode","program":false,"enum":false,"alias":false,"const":false,"namespace":{"html_id":"cryode/Cryode/Fields","kind":"module","full_name":"Cryode::Fields","name":"Fields"},"constructors":[{"html_id":"new-class-method","name":"new","abstract":false,"location":{"filename":"src\\cryode\\fields\\bool.cr","line_number":5,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\fields\\bool.cr#L5"},"def":{"name":"new","visibility":"Public","body":"x = allocate\nif x.responds_to?(:finalize)\n  ::GC.add_finalizer(x)\nend\nx\n"}}],"instance_methods":[{"html_id":"initialize-instance-method","name":"initialize","abstract":false,"location":{"filename":"src\\cryode\\fields\\bool.cr","line_number":5,"url":"https://github.com/kebasyaty/cryode/blob/ce1d14dc09f68d0b52b55d9f3007006d60b928a4/src\\cryode\\fields\\bool.cr#L5"},"def":{"name":"initialize","visibility":"Public","body":""}}]}]}]}]}})