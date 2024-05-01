require "./tools"
require "./caching"
require "./check"
require "./password"
require "./save"
require "./fixtures"

# Paladins - Model instance methods.
module DynFork::QPaladins
  include DynFork::QPaladins::Tools
  include DynFork::QPaladins::Caching
  include DynFork::QPaladins::Check
  include DynFork::QPaladins::Password
  include DynFork::QPaladins::Save
  include DynFork::QPaladins::Fixtures
end
