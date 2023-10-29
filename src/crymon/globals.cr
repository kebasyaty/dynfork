module Crymon
  module Globals
    # All field types.
    alias FieldTypes = Crymon::Fields::URLField | Crymon::Fields::TextField |
                       Crymon::Fields::SlugField | Crymon::Fields::PhoneField |
                       Crymon::Fields::PasswordField | Crymon::Fields::U32Field |
                       Crymon::Fields::I64Field | Crymon::Fields::F64Field |
                       Crymon::Fields::IPField | Crymon::Fields::ImageField |
                       Crymon::Fields::HashField | Crymon::Fields::FileField |
                       Crymon::Fields::EmailField | Crymon::Fields::DateTimeField |
                       Crymon::Fields::DateField | Crymon::Fields::ColorField |
                       Crymon::Fields::ChoiceU32Field | Crymon::Fields::ChoiceU32MultField |
                       Crymon::Fields::ChoiceU32DynField | Crymon::Fields::ChoiceU32MultDynField |
                       Crymon::Fields::ChoiceTextField | Crymon::Fields::ChoiceTextMultField |
                       Crymon::Fields::ChoiceTextDynField | Crymon::Fields::ChoiceTextMultDynField |
                       Crymon::Fields::ChoiceI64Field | Crymon::Fields::ChoiceI64MultField |
                       Crymon::Fields::ChoiceI64DynField | Crymon::Fields::ChoiceI64MultDynField |
                       Crymon::Fields::ChoiceF64Field | Crymon::Fields::ChoiceF64MultField |
                       Crymon::Fields::ChoiceF64DynField | Crymon::Fields::ChoiceF64MultDynField |
                       Crymon::Fields::BoolField
  end
end
