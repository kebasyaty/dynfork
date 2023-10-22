require "../spec_helper"

describe Crymon do
  describe "Crymon::Model" do
    describe ".new" do
      it "create instance of Model" do
        m = ModelName.new
        m.model_name.should eq("")
      end
    end
  end
end
