module DynFork::Paladins::Password
  # For password verification.
  def verify_password?(
    password : String,
    field_name : String = "password"
  ) : Bool
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    #
    if id : BSON::ObjectId? = self.object_id?
      # Get collection for current model.
      collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
        @@meta.not_nil![:collection_name]]
      # Get password hash.
      if doc = collection.find_one({_id: id})
        return Crypto::Bcrypt::Password.new(doc[field_name].as(String)).verify(password)
      end
      msg = "Model: `#{@@full_model_name}` > " +
            "Field: `#{field_name}` | Method: `#verify_password` => " +
            "There is no document with ID `#{@hash.value}` in the database."
      raise DynFork::Errors::Panic.new msg
    end
    msg = "Model: `#{@@full_model_name}` > " +
          "Field: `#{field_name}` | Method: `#verify_password` => " +
          "Cannot get document ID - Hash field is empty."
    raise DynFork::Errors::Panic.new msg
  end

  # For replace or recover password.
  def update_password(
    old_password : String,
    new_password : String,
    field_name : String = "password"
  ) : Void
    unless self.verify_password?(old_password, field_name)
      raise DynFork::Errors::Password::OldPassNotMatch.new(I18n.t(:old_pass_not_match))
    end
    # Get collection for current model.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Get password hash.
    password_hash : String = Crypto::Bcrypt::Password.create(new_password).to_s
    # Update password.
    filter = {_id: self.object_id?}
    update = {"$set": {field_name => password_hash}}
    collection.update_one(filter, update)
  end
end
