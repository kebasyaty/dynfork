# Standard:
require "json"
require "base64"
require "crypto/bcrypt/password"
require "uuid"
# Third party libraries:
require "cryomongo"
require "bson"
require "i18n"
require "validator"
require "pluto"
require "pluto/format/jpeg"
require "pluto/format/png"
require "pluto/format/webp"
require "webslug"
# DynFork:
require "./dynfork/errors/*"
require "./dynfork/globals/store"
require "./dynfork/tools/*"
require "./dynfork/fields/*"
require "./dynfork/meta"
require "./dynfork/model"
require "./dynfork/migration"

# ORM-like API MongoDB for Crystal.
# <br>
# For simulate relationship Many-to-One and Many-to-Many,
# <br>
# a simplified alternative (Types of selective fields with dynamic addition of elements) is used.
# <br>
# The project is focused on web development.
# <br>
# <br>
# _Compatible with MongoDB 3.6+. Tested against: 4.4, 6.0, 7.0._
# <br>
# _For more information see [Cryomongo](https://github.com/elbywan/cryomongo "Cryomongo")_.
# <br>
# <br>
#  Copyright (c) 2023 kebasyaty - Gennady Kostyunin
# <br>
#  DynFork is free software under terms of the MIT License.
#
module DynFork
  VERSION = "0.1.0"
end

unless Dir.exists?("tmp")
  Dir.mkdir_p(path: "tmp", mode: 0o777)
end

module Validator
  # Custom validator for checking color code.
  def self.color?(value : String) : Bool
    DynFork::Globals.cache_regex[:color_code].matches?(value)
  end
end
