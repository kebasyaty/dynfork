require "./unit"
require "./converter"
require "./general"
require "./many"
require "./one"
require "./indexes"

# Commons - Model class methods.
module DynFork::Commons
  include DynFork::Commons::UnitsManagement
  include DynFork::Commons::Converter
  include DynFork::Commons::QGeneral
  include DynFork::Commons::QMany
  include DynFork::Commons::QOne
  include DynFork::Commons::Indexes
end
