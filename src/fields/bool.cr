require "./field"

module Fields
  # Boolean field.
  class BoolField < Fields::Field
    property field_type : String = "BoolField"
    property input_type : String = "checkbox"
    property value : Bool | Nil
    property default : Bool | Nil = false
  end
end
