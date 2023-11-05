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
      f.is_disabled.should be_false
      f.is_readonly.should be_false
      f.is_hide.should be_false
      f.is_required.should be_false
      f.is_unique.should be_false
      f.maxlength.should eq(256)
      f.minlength.should eq(0)
      f.other_attrs.should eq("")
      f.css_classes.should eq("")
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(1_u8)
      f["default"]?.should be_true
      f["no_var"]?.should be_false
    end

    it "=> create an instance with input_type=color", tags: "fields" do
      f = Crymon::Fields::ColorField.new(
        input_type: "color"
      )
      f.input_type.should eq("color")
    end

    it "=> invalid input type - input_type=???", tags: "fields" do
      t : String = "???"
      ex = expect_raises(Crymon::Errors::InvalidInputType) do
        Crymon::Fields::ColorField.new(
          input_type: t
        )
      end
      ex.message.should eq %(The "#{t}" invalid input type.)
    end
  end
end
