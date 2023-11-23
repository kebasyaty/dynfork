require "./addition_impl"

module Crymon
  # Mediator for multiple inheritance, for an abstract Model.
  abstract struct Implement < Crymon::Addition; end
end
