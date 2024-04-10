require "./unit"
require "./general"
require "./indexes"
require "./many"
require "./one"

# Commons - Model class methods.
module DynFork::Commons
  include DynFork::Commons::UnitsManagement
  include DynFork::Commons::Indexes
  include DynFork::Commons::QMany
  include DynFork::Commons::QOne
end
