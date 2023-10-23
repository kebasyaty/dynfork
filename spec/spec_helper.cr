require "spec"
require "../src/crymon"

module Helper
  # Model without variables and methods.
  struct EmptyModel < Crymon::Model; end
end
