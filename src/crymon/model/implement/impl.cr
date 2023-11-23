require "./addition_impl"

module Crymon::Implement
  # Mediator for multiple inheritance, for an abstract Model.
  abstract struct Implement < Crymon::Implement::Addition; end
end
