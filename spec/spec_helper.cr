require "spec"
require "../src/crymon"

module Helper
  # Model without variables and methods.
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  struct FilledModel < Crymon::Model
    getter name : String
    getter age : Int32

    def initialize(
      @name : String,
      @age : Int32
    ); end
  end
end
