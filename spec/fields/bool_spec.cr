require "../spec_helper"

describe Fields do
  describe "Fields::Boolean" do
    describe ".new" do
      it "create an instance of the Boolean field" do
        f = Fields::Boolean.new
        f.id.should eq("")
      end
    end
  end
end
