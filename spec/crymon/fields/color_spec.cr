require "../../spec_helper"

describe Crymon::Fields::ColorField do
  describe ".new" do
    it "=> create instance of Color field", tags: "fields" do
      f = Crymon::Fields::ColorField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ColorField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value.should be_nil
      f.default.should eq("#000000")
      f.placeholder.should eq("")
      f.is_disabled?.should be_false
      f.is_readonly?.should be_false
      f.is_hide?.should be_false
      f.is_required?.should be_false
      f.is_unique?.should be_false
      f.is_ignored?.should be_false
      f.maxlength.should eq(256)
      f.minlength.should eq(0)
      f.hint.should eq("Examples: #fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) | rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end
  end
end
