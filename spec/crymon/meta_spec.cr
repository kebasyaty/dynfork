require "../spec_helper"

describe Crymon do
  describe "Crymon::Meta" do
    describe ".new" do
      it "create instance of Meta" do
        m = Crymon::Meta.new
        m.model_name.should eq("")
      end
    end
  end
end
