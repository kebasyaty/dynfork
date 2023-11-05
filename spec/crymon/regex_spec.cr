require "../spec_helper"

describe "Regular Expression" do
  it "=> for model name" do
    # Negative:
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("").should be_false
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("360").should be_false
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("accounts").should be_false
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("Model Name").should be_false
    # > 25 characters
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("Loremipsumdolorsitametcons").should be_false
    # Positive:
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("Accounts").should be_true
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("ACCOUNTS").should be_true
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("ModelName").should be_true
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("ModelName360").should be_true
    /^[A-Z][a-zA-Z0-9]{0,24}$/.matches?("MODELNAME360").should be_true
  end

  it "=> for app name" do
    # Negative:
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("").should be_false
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("electric car store").should be_false
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("electric-car store").should be_false
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("Electric Car_Store").should be_false
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("").should be_false
    # Positive:
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("electric_car_store").should be_true
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("electric-car-store").should be_true
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("Electric_Car_Store").should be_true
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("Electric-Car_Store").should be_true
    /^[a-zA-Z][-_a-zA-Z0-9]{0,43}$/.matches?("ElectricCarStore").should be_true
  end
end
