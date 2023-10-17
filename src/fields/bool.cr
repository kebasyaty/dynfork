require "./field"

module Fields
  # Boolean field.
  class Boolean < Fields::Field
    property value : Bool | Nil
    property default : Bool | Nil = false
  end
end
