require "./addition_impl"

module Crymon::Implement
  # Mediator for multiple inheritance, for an abstract Model.
  abstract struct Mediator < Crymon::Implement::Addition; end
end
