# Standard:
require "json"
require "yaml"
require "base64"
require "crypto/bcrypt/password"
require "uuid"
require "file_utils"
require "colorize"
require "big/big_decimal"
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
require "./dynfork/fields/*"
require "./dynfork/meta"
require "./dynfork/model"
require "./dynfork/migration"

# ██████╗░██╗░░░██╗███╗░░██╗███████╗░█████╗░██████╗░██╗░░██╗<br>
# ██╔══██╗╚██╗░██╔╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░██╔╝<br>
# ██║░░██║░╚████╔╝░██╔██╗██║█████╗░░██║░░██║██████╔╝█████═╝░<br>
# ██║░░██║░░╚██╔╝░░██║╚████║██╔══╝░░██║░░██║██╔══██╗██╔═██╗░<br>
# ██████╔╝░░░██║░░░██║░╚███║██║░░░░░╚█████╔╝██║░░██║██║░╚██╗<br>
# ╚═════╝░░░░╚═╝░░░╚═╝░░╚══╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝
# <br>
# <br>
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
#  DynFork is free software under terms of the Apache Version 2.0 and MIT License.
module DynFork
  VERSION = "0.1.0"
end

module Validator
  # Custom validator for checking color code.
  # <br>
  # _Examples: #fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) |
  # rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff_#
  def self.color_code?(value : String) : Bool
    DynFork::Globals.regex[:color_code].matches?(value)
  end

  # Custom validator to validate the password string.
  def self.password?(value : String) : Bool
    DynFork::Globals.regex[:password].matches?(value)
  end
end
