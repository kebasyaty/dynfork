require "./tools"
require "./caching"
require "./check"
require "./password"
require "./save"

# Paladins - Model instance methods.
module DynFork::Paladins
  include DynFork::Paladins::Tools
  include DynFork::Paladins::Caching
  include DynFork::Paladins::Check
  include DynFork::Paladins::Password
  include DynFork::Paladins::Save
end
