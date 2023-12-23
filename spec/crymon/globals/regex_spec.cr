require "../../spec_helper"

describe Crymon::Globals do
  it "=> cache_regex - type checking", tags: "global_regex" do
    Crymon::Globals.cache_regex.should eq(
      NamedTuple.new(
        model_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
        app_name: /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/,
        unique_app_key: /^[a-zA-Z0-9]{16}$/,
        service_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
        get_type_marker: /(Text|U32|I64|F64)/,
        date_parse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})$/,
        date_parse_reverse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})$/,
        datetime_parse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})$/,
        datetime_parse_reverse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2})$/,
      )
    )
  end

  describe "Regular Expression" do
    it "=> for model_name", tags: "global_regex" do
      r : Regex = Crymon::Globals.cache_regex[:model_name]
      # Negative:
      r.matches?("").should be_false
      r.matches?("360").should be_false
      r.matches?("accounts").should be_false
      r.matches?("Model Name").should be_false
      # > 25 characters
      r.matches?("Loremipsumdolorsitametcons").should be_false
      # Positive:
      r.matches?("Accounts").should be_true
      r.matches?("ACCOUNTS").should be_true
      r.matches?("ModelName").should be_true
      r.matches?("ModelName360").should be_true
      r.matches?("MODELNAME360").should be_true
    end

    it "=> for app_name", tags: "global_regex" do
      r : Regex = Crymon::Globals.cache_regex[:app_name]
      # Negative:
      r.matches?("").should be_false
      r.matches?("electric car store").should be_false
      r.matches?("electric-car store").should be_false
      r.matches?("Electric Car_Store").should be_false
      # > 44 characters
      r.matches?("Loremipsumdolorsitametconsloremipsumdolorsita").should be_false
      # Positive:
      r.matches?("electric_car_store").should be_true
      r.matches?("electric-car-store").should be_true
      r.matches?("Electric_Car_Store").should be_true
      r.matches?("Electric-Car_Store").should be_true
      r.matches?("ElectricCarStore").should be_true
    end

    # To generate a key (This is not an advertisement): https://randompasswordgen.com/
    it "=> for unique_app_key", tags: "global_regex" do
      r : Regex = Crymon::Globals.cache_regex[:unique_app_key]
      # Negative:
      r.matches?("").should be_false
      # < 16 characters
      r.matches?("Ia2g8163MI59Zs8").should be_false
      # > 16 characters
      r.matches?("K73H5f1z812j61728").should be_false
      r.matches?("/A[gX5)^?7o[1R~y").should be_false
      # Positive:
      r.matches?("7721W783kPX7EFOu").should be_true
      r.matches?("E5lo5Z8i5m2K6W75").should be_true
      r.matches?("x4N83BGV26b3Npg2").should be_true
    end

    it "=> for service_name", tags: "global_regex" do
      r : Regex = Crymon::Globals.cache_regex[:service_name]
      # Negative:
      r.matches?("").should be_false
      r.matches?("Auto parts").should be_false
      r.matches?("Auto Parts").should be_false
      r.matches?("autoparts").should be_false
      r.matches?("Auto_parts").should be_false
      r.matches?("Auto-parts").should be_false
      # > 25 characters
      r.matches?("Loremipsumdolorsitametcons").should be_false
      # Positive:
      r.matches?("AutoParts").should be_true
      r.matches?("Autoparts").should be_true
      r.matches?("AutoParts360").should be_true
    end
  end
end
