require "./caching"
require "./check"

# Paladins - Model instance methods.
module Crymon::Paladins
  include Crymon::Paladins::Caching
  include Crymon::Paladins::Check
end
