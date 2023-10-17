# Boolean field.

module Fields
  abstract class Field
    property id : String = ""
    property label : String = ""
    property field_type : String = "Boolean"
    property input_type : String = "checkbox"
    property name : String = ""
    property value : Bool | Nil
  end
end
