require "../spec_helper"

describe Crymon do
  describe "Crymon::Fields::U32Field" do
    describe ".new" do
      it "create instance of UInt32 field" do
        f = Crymon::Fields::U32Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("U32Field")
        f.input_type.should eq("number") # number | range
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.max.should eq(UInt32::MAX)
        f.min.should eq(0_u32)
        f.step.should eq(1_u32)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(11_u8)
      end

      it "create instance with input_type=range" do
        f = Crymon::Fields::U32Field.new(
          input_type: "range"
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - input_type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::Errors::InvalidInputType) do
          Crymon::Fields::U32Field.new(
            input_type: t
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end

  describe "Crymon::Fields::I64Field" do
    describe ".new" do
      it "create instance of Int64 field" do
        f = Crymon::Fields::I64Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("I64Field")
        f.input_type.should eq("number") # number | range
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.max.should eq(Int64::MAX)
        f.min.should eq(0_i64)
        f.step.should eq(1_i64)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(11_u8)
      end

      it "create instance with input_type=range" do
        f = Crymon::Fields::I64Field.new(
          input_type: "range"
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - input_type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::Errors::InvalidInputType) do
          Crymon::Fields::I64Field.new(
            input_type: t
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end

  describe "Crymon::Fields::F64Field" do
    describe ".new" do
      it "create instance of Float64 field" do
        f = Crymon::Fields::F64Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("F64Field")
        f.input_type.should eq("number") # number | range
        f.name.should eq("")
        f.value.should be_nil
        f.default.should be_nil
        f.placeholder.should eq("")
        f.is_disabled.should be_false
        f.is_readonly.should be_false
        f.is_hide.should be_false
        f.is_required.should be_false
        f.is_unique.should be_false
        f.max.should eq(Float64::MAX)
        f.min.should eq(0_f64)
        f.step.should eq(1_f64)
        f.other_attrs.should eq("")
        f.css_classes.should eq("")
        f.hint.should eq("")
        f.warning.should eq("")
        f.errors.should eq(Array(String).new)
        f.group.should eq(12_u8)
      end

      it "create instance with input_type=range" do
        f = Crymon::Fields::F64Field.new(
          input_type: "range"
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - input_type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::Errors::InvalidInputType) do
          Crymon::Fields::F64Field.new(
            input_type: t
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end
end
