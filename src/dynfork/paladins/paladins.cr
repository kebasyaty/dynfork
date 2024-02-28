require "./caching"
require "./check"
require "./password"

# Paladins - Model instance methods.
module DynFork::Paladins
  include DynFork::Paladins::Caching
  include DynFork::Paladins::Check
  include DynFork::Paladins::Password
end
