require "./caching"
require "./fields"
require "./meta"
require "./model"
require "./date"
require "./types"

# Custom exceptions for Crymon.
module Crymon::Errors
  include Crymon::Errors::Caching
  include Crymon::Errors::Fields
  include Crymon::Errors::Meta
  include Crymon::Errors::Model
  include Crymon::Errors::Date
  include Crymon::Errors::Types
end
