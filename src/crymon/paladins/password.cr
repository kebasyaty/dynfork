module Crymon::Paladins::Password
  # Password verification.
  def verify_password(password : String, field_name : String = "password") : Bool
    if doc_id = self.get_object_id
      # Get collection for current model.
      collection : Mongo::Collection = Crymon::Globals.cache_mongo_database.not_nil![
        @@meta.not_nil![:collection_name]]
      # Get password hash.
      password_hash : String = Crypto::Bcrypt::Password.create(password).to_s
      return !collection.find_one({"_id" => doc_id, field_name => password_hash}).nil?
    end
    raise "Panic - Model: `#{@@meta.not_nil![:model_name]}` > " +
          "Field: `#{field_name}` | Method: `verify_password` => " +
          "Cannot get document ID - Hash field is empty."
  end
end
