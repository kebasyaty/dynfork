require "../../spec_helper"

describe DynFork::Fields::I64Field do
  describe ".new" do
    it "=> create instance of Int64 field", tags: "fields" do
      f = DynFork::Fields::I64Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("I64Field")
      f.input_type.should eq("number") # number | range
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.max.should eq(Int64::MAX)
      f.min.should eq(Int64::MIN)
      f.step.should eq(1_i64)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(6_u8)
    end

    it "=> create instance with input_type=range", tags: "fields" do
      f = DynFork::Fields::I64Field.new(
        input_type: "range"
      )
      f.input_type.should eq("range")
    end

    it "=> invalid input type - input_type=???", tags: "fields" do
      t : String = "???"
      ex = expect_raises(DynFork::Errors::Fields::InvalidInputType) do
        DynFork::Fields::I64Field.new(
          input_type: t
        )
      end
      ex.message.should eq "The `#{t}` invalid input type!"
    end
  end
end

describe DynFork::Fields::F64Field do
  describe ".new" do
    it "=> create instance of Float64 field", tags: "fields" do
      f = DynFork::Fields::F64Field.new
      f.id.should eq("")
      f.label.should eq("")
      f.field_type.should eq("F64Field")
      f.input_type.should eq("number") # number | range
      f.name.should eq("")
      f.value?.should be_nil
      f.default?.should be_nil
      f.placeholder.should eq("")
      f.disabled?.should be_false
      f.readonly?.should be_false
      f.hide?.should be_false
      f.required?.should be_false
      f.unique?.should be_false
      f.ignored?.should be_false
      f.max.should eq(Float64::MAX)
      f.min.should eq(Float64::MIN)
      f.step.should eq(1_f64)
      f.hint.should eq("")
      f.warning.should eq("")
      f.errors.should eq(Array(String).new)
      f.group.should eq(7_u8)
      # Financial methods.
      f.finance_plus 12.5
      f.value.should eq 12.5
      f.finance_minus 6.25
      f.value.should eq 6.25
    end

    it "=> create instance with input_type=range", tags: "fields" do
      f = DynFork::Fields::F64Field.new(
        input_type: "range"
      )
      f.input_type.should eq("range")
    end

    it "=> invalid input type - input_type=???", tags: "fields" do
      t : String = "???"
      ex = expect_raises(DynFork::Errors::Fields::InvalidInputType) do
        DynFork::Fields::F64Field.new(
          input_type: t
        )
      end
      ex.message.should eq "The `#{t}` invalid input type!"
    end
  end
end
