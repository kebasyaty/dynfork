require "../../spec_helper"

describe Crymon::Model do
  describe "#is_valid" do
    it "=> validation instance of Model", tags: "validation" do
      m = Helper::FilledModel.new
      m.is_valid.should be_true
      m.print_err.should be_nil
    end
  end
end
