require "../../spec_helper"

describe DynFork::Globals do
  it "=> regex - type checking", tags: "global_regex" do
    DynFork::Globals.regex.should eq(
      NamedTuple.new(
        database_name: /^[-_a-zA-Z0-9]+$/,
        service_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
        model_name: /^[A-Z][a-zA-Z0-9]{0,24}$/,
        get_type_marker: /(Text|U32|I64|F64)/,
        date_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})$/,
        date_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})$/,
        datetime_parse: /^(?P<d>[0-9]{2})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<y>[0-9]{4})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2}:[0-9]{2})/,
        datetime_parse_reverse: /^(?P<y>[0-9]{4})[-\/\.](?P<m>[0-9]{2})[-\/\.](?P<d>[0-9]{2})(?:T|\s)(?<t>[0-9]{2}:[0-9]{2}:[0-9]{2})/,
        color_code: /^(?:#|0x)(?:[a-f0-9]{3}|[a-f0-9]{6}|[a-f0-9]{8})\b|(?:rgb|hsl)a?\([^\)]*\)$/i,
        password: /^[-._!"`'#%&,:;<>=@{}~\$\(\)\*\+\/\\\?\[\]\^\|a-zA-Z0-9]+$/,
      )
    )
  end

  describe "Regular Expression" do
    it "=> regex - database_name", tags: "global_regex" do
      r : Regex = DynFork::Globals.regex[:database_name]
      # Negative:
      r.matches?("").should be_false
      r.matches?("Database Name").should be_false
      r.matches?(" DatabaseName").should be_false
      r.matches?("Database_Name").should be_false
      r.matches?("Database-Name").should be_false
      r.matches?("_DatabaseName").should be_false
      r.matches?("-DatabaseName").should be_false
      # > 60 characters
      r.matches?("LoremIpsumDolorSitAmetConsecteturAdipiscingElitIntegerLacinia").should be_false
      # Positive:
      r.matches?("DatabaseName").should be_true
      r.matches?("databaseName").should be_true
      r.matches?("5databaseName").should be_true
      r.matches?("E5lo5Z8i5m2K6W75").should be_true
      r.matches?("x4N83BGV26b3Npg2").should be_true
      r.matches?("7721W783kPX7EFOu").should be_true
    end
    it "=> regex - service_name", tags: "global_regex" do
      r : Regex = DynFork::Globals.regex[:service_name]
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

    it "=> regex - model_name", tags: "global_regex" do
      r : Regex = DynFork::Globals.regex[:model_name]
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

    it "=> regex - color_code", tags: "global_regex" do
      r : Regex = DynFork::Globals.regex[:color_code]
      # Negative:
      r.matches?("").should be_false
      r.matches?("#f2ewq").should be_false
      # Positive:
      r.matches?("#fff").should be_true
      r.matches?("#f2f2f2").should be_true
      r.matches?("#F2F2F2").should be_true
      r.matches?("#00000000").should be_true
      r.matches?("rgb(255,0,24)").should be_true
      r.matches?("rgb(255, 0, 24)").should be_true
      r.matches?("rgba(255, 0, 24, .5)").should be_true
      r.matches?("rgba(#fff, .5)").should be_true
      r.matches?("rgba(#fff,.5)").should be_true
      r.matches?("rgba(#FFF, .5)").should be_true
      r.matches?("rgba(#FFF,.5)").should be_true
      r.matches?("hsl(120, 100%, 50%)").should be_true
      r.matches?("hsl(120,100%,50%)").should be_true
      r.matches?("hsla(170, 23%, 25%, 0.2)").should be_true
      r.matches?("hsla(170,23%,25%,0.2)").should be_true
      r.matches?("0x00ffff").should be_true
      r.matches?("0x00FFFF").should be_true
    end

    it "=> regex - password", tags: "global_regex" do
      r : Regex = DynFork::Globals.regex[:password]
      # Negative:
      r.matches?("").should be_false
      r.matches?(" ").should be_false
      # Positive:
      r.matches?("9M,4%6]3ht7r{l59").should be_true
      r.matches?("2XT~m:L!Hz_723J(").should be_true
      r.matches?("d6'P30}e'#f^g3t5").should be_true
    end
  end
end
