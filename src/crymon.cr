require "./crymon/errors/errors"
#
require "./crymon/globals/globals"
require "./crymon/tools/*"
#
require "./crymon/fields/*"
#
require "./crymon/meta"
require "./crymon/model"
#
require "./crymon/migration"
#
require "cryomongo"
require "bson"

# ORM-like API MongoDB for Crystal.
# <br>
# For simulate relationship Many-to-One and Many-to-Many,
# <br>
# a simplified alternative (Types of selective fields with dynamic addition of elements) is used.
# <br>
# The project is focused on web development.
# <br>
# <br>
# _Compatible with MongoDB 3.6+. Tested against: 6.0, 7.0._
# <br>
# _For more information see [Cryomongo](https://github.com/elbywan/cryomongo "Cryomongo")_.
module Crymon
  VERSION = "0.1.0"
end
