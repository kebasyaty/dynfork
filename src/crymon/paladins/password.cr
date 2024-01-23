module Crymon::Paladins::Password
  # For password verification.
  def verify_password(
    password : String,
    field_name : String = "password"
  ) : Bool
    if doc_id = self.get_object_id
      # Get collection for current model.
      collection : Mongo::Collection = Crymon::Globals.cache_mongo_database.not_nil![
        @@meta.not_nil![:collection_name]]
      # Get password hash.
      if doc = collection.find_one({"_id" => doc_id})
        return Crypto::Bcrypt::Password.new(doc[field_name]).verify
      end
      msg = "Model: `#{@@meta.not_nil![:model_name]}` > " +
            "Field: `#{field_name}` | Method: `verify_password` => " +
            "There is no document with ID `#{@hash.value}` in the database."
      raise Crymon::Errors::Panic.new msg
    end
    msg = "Model: `#{@@meta.not_nil![:model_name]}` > " +
          "Field: `#{field_name}` | Method: `verify_password` => " +
          "Cannot get document ID - Hash field is empty."
    raise Crymon::Errors::Panic.new msg
  end

  # For replace or recover password.
  def update_password(
    old_password : String,
    new_password : String,
    field_name : String = "password"
  ) : String?
    return I18n.t(:old_pass_not_match) unless verify_password(old_password, field_name)
    # Get collection for current model.
    collection : Mongo::Collection = Crymon::Globals.cache_mongo_database.not_nil![
      @@meta.not_nil![:collection_name]]
    # Get password hash.
    password_hash : String = Crypto::Bcrypt::Password.create(new_password).to_s
    # Update password.
    filter = {"_id" => self.get_object_id}
    update = {"$set": {field_name => password_hash}}
    collection.update_one(filter, update)
  end
end
