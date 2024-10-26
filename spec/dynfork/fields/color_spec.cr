require "../../spec_helper"

describe DynFork::Fields::ColorField do
  describe ".new" do
    it "=> create instance of Color field", tags: "fields" do
      f = DynFork::Fields::ColorField.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("ColorField")
      f.input_type.should eq("text")
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should eq("#000000")
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.maxlength.should eq(256)
      f.minlength.should eq(0)
      f.hint.should eq("")
      f.warning.should eq(["Examples: #fff | #f2f2f2 | #f2f2f200 | rgb(255,0,24) | rgba(255,0,24,0.5) | rgba(#fff,0.5) | hsl(120,100%,50%) | hsla(170,23%,25%,0.2) | 0x00ffff"])
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
    end
  end
end
