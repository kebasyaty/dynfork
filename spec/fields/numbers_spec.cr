require "../spec_helper"

describe Fields do
  describe "Fields::U32Field" do
    describe ".new" do
      it "create an instance of the UInt32 field" do
        f = Fields::U32Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("U32Field")
        f.input_type.should eq("number")
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
        f.group.should eq(11_u32)
      end

      it "create an instance with input_type=range" do
        f = Fields::U32Field.new(
          label : String = "",
          default : UInt32 | Nil = nil,
          input_type : String = "range", # number | range
          placeholder : String = "",
          max : UInt32 = UInt32::MAX,
          min : UInt32 = 0,
          step : UInt32 = 1,
          is_hide : Bool = false,
          is_unique : Bool = false,
          is_required : Bool = false,
          is_disabled : Bool = false,
          is_readonly : Bool = false,
          other_attrs : String = "",
          css_classes : String = "",
          hint : String = "",
          warning : String = ""
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::InvalidInputType) do
          Fields::U32Field.new(
            label : String = "",
            default : UInt32 | Nil = nil,
            input_type : String = t, # number | range
            placeholder : String = "",
            max : UInt32 = UInt32::MAX,
            min : UInt32 = 0,
            step : UInt32 = 1,
            is_hide : Bool = false,
            is_unique : Bool = false,
            is_required : Bool = false,
            is_disabled : Bool = false,
            is_readonly : Bool = false,
            other_attrs : String = "",
            css_classes : String = "",
            hint : String = "",
            warning : String = ""
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end

  describe "Fields::I64Field" do
    describe ".new" do
      it "create an instance of the Int64 field" do
        f = Fields::I64Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("I64Field")
        f.input_type.should eq("number")
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
        f.group.should eq(11_u32)
      end

      it "create an instance with input_type=range" do
        f = Fields::I64Field.new(
          label : String = "",
          default : Int64 | Nil = nil,
          input_type : String = "range", # number | range
          placeholder : String = "",
          max : Int64 = Int64::MAX,
          min : Int64 = 0,
          step : Int64 = 1,
          is_hide : Bool = false,
          is_unique : Bool = false,
          is_required : Bool = false,
          is_disabled : Bool = false,
          is_readonly : Bool = false,
          other_attrs : String = "",
          css_classes : String = "",
          hint : String = "",
          warning : String = ""
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::InvalidInputType) do
          Fields::I64Field.new(
            label : String = "",
            default : Int64 | Nil = nil,
            input_type : String = t, # number | range
            placeholder : String = "",
            max : Int64 = Int64::MAX,
            min : Int64 = 0,
            step : Int64 = 1,
            is_hide : Bool = false,
            is_unique : Bool = false,
            is_required : Bool = false,
            is_disabled : Bool = false,
            is_readonly : Bool = false,
            other_attrs : String = "",
            css_classes : String = "",
            hint : String = "",
            warning : String = ""
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end

  describe "Fields::F64Field" do
    describe ".new" do
      it "create an instance of the Float64 field" do
        f = Fields::F64Field.new
        f.id.should eq("")
        f.label.should eq("")
        f.field_type.should eq("F64Field")
        f.input_type.should eq("number")
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
        f.group.should eq(12_u32)
      end

      it "create an instance with input_type=range" do
        f = Fields::F64Field.new(
          label : String = "",
          default : Float64 | Nil = nil,
          input_type : String = "range", # number | range
          placeholder : String = "",
          max : Float64 = Float64::MAX,
          min : Float64 = 0.0,
          step : Float64 = 1.0,
          is_hide : Bool = false,
          is_unique : Bool = false,
          is_required : Bool = false,
          is_disabled : Bool = false,
          is_readonly : Bool = false,
          other_attrs : String = "",
          css_classes : String = "",
          hint : String = "",
          warning : String = ""
        )
        f.input_type.should eq("range")
      end

      it "invalid input type - type=???" do
        t : String = "???"
        ex = expect_raises(Crymon::InvalidInputType) do
          Fields::F64Field.new(
            label : String = "",
            default : Float64 | Nil = nil,
            input_type : String = t, # number | range
            placeholder : String = "",
            max : Float64 = Float64::MAX,
            min : Float64 = 0.0,
            step : Float64 = 1.0,
            is_hide : Bool = false,
            is_unique : Bool = false,
            is_required : Bool = false,
            is_disabled : Bool = false,
            is_readonly : Bool = false,
            other_attrs : String = "",
            css_classes : String = "",
            hint : String = "",
            warning : String = ""
          )
        end
        ex.message.should eq %(The "#{t}" invalid input type.)
      end
    end
  end
end
