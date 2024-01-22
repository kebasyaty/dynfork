require "./caching"
require "./check"
require "./password"

# Paladins - Model instance methods.
module Crymon::Paladins
  include Crymon::Paladins::Caching
  include Crymon::Paladins::Check
  include Crymon::Paladins::Password
end
