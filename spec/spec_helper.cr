require "spec"
require "../src/crymon"

module Helper
  # Model without variables and methods.
  struct EmptyModel < Crymon::Model; end

  # Model with variables and methods.
  struct FilledModel < Crymon::Model
    getter name : String
    getter age : UInt32
    getter birthday : Helper::Birthday

    def initialize(
      @name : String,
      @age : UInt32,
      @birthday = Helper::Birthday.new
    ); end
  end

  # For testing: Helper::Birthday to Birthday in Model.
  struct Birthday
    getter date : String = "1990-11-7"
  end
end
