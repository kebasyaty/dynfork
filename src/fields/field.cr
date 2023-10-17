# Boolean field.

module Fields
  abstract class Field
    property id : String = ""
    property label : String = ""
    property field_type
    property input_type
    property value
    property default
    property name : String = ""
    property placeholder : String = ""
    property is_disabled : Bool = false
    property is_readonly : Bool = false
    property is_hide : Bool = false
    property other_attrs : String = ""
    property css_classes : String = ""
    property hint : String = ""
    property warning : String = ""
    property errors : Array(String) = Array(String).new
    property group : UInt32 = 13
  end
end
