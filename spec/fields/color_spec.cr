require "../spec_helper"

describe Fields do
  describe "Fields::ColorField" do
    describe ".new" do
      it "create an instance of the Color field" do
        f = Fields::ColorField.new
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
        f.group.should eq(1_u32)
      end

      it "create an instance with input_type=color" do
        f = Fields::ColorField.new(
          label : String = "",
          default : String | Nil = "#000000",
          input_type : String = "color", # text | color
          placeholder : String = "",
          maxlength : UInt32 = 256,
          minlength : UInt32 = 0,
          is_hide : Bool = false,
          is_unique : Bool = false,
          is_required : Bool = false,
          is_disabled : Bool = false,
          is_readonly : Bool = false,
          other_attrs : String = "",
          css_classes : String = "",
          hint : String = ""
        )
        f.input_type.should eq("color")
      end

      it "invalid input type - type=???" do
        t : String = "???"
        ex = expect_raises(Cryod::InvalidInputType) do
          Fields::ColorField.new(
            label : String = "",
            default : String | Nil = "#000000",
            input_type : String = t, # text | color
            placeholder : String = "",
            maxlength : UInt32 = 256,
            minlength : UInt32 = 0,
            is_hide : Bool = false,
            is_unique : Bool = false,
            is_required : Bool = false,
            is_disabled : Bool = false,
            is_readonly : Bool = false,
            other_attrs : String = "",
            css_classes : String = "",
            hint : String = ""
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end
end
