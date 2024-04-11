# ???
module DynFork::Commons::Converter
  extend self

  # ???
  def document_to_hash(doc_ptr : Pointer(BSON)) : Hash(String, DynFork::Globals::ValueTypes)
    field_type : String = ""
    name : String = ""
    doc = doc_ptr.value.not_nil!.to_h
    doc_hash = Hash(String, DynFork::Globals::ValueTypes).new
    #
    {% for field in @type.instance_vars %}
      name = @{{ field }}.name
      #
      (doc_hash["hash"] = doc["_id"].as(BSON::ObjectId).to_s) if name == "hash"
      #
    {% end %}
    #
    doc_hash
  end
end
