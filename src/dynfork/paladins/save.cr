# Creating and updating documents in the database.
module DynFork::Paladins::Save
  # Creating and updating documents in the database.
  # <br>
  # This method pre-uses the _check_ method.
  #
  # Simple example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  #
  # user = User.new
  # user.username.value = "username"
  # user.birthday.value = "1970-01-01"
  #
  # user.print_err unless user.save
  # # print_err - convenient during development.
  # ```
  #
  def save : Bool
    unless @@meta.not_nil![:migrat_model?]
      raise DynFork::Errors::Panic.new(
        "Model : `#{@@full_model_name}` > Param: `migrat_model?` => " +
        "This Model is not migrated to the database!"
      )
    end
    # Get collection.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Check and get output data.
    output_data : DynFork::Globals::OutputData = self.check(
      collection_ptr: pointerof(collection),
      save?: true
    )
    # Check the conditions and, if necessary, define a message for the web form.
    # <br>
    # Reset the alerts to exclude duplicates.
    @hash.alerts = Array(String).new
    if !output_data.update? && !@@meta.not_nil![:create_doc?]
      @hash.alerts << I18n.t(:forbidden_creating_docs)
      output_data.valid = false
    end
    if output_data.update? && !@@meta.not_nil![:update_doc?]
      @hash.alerts << I18n.t(:forbidden_updating_docs)
      output_data.valid = false
    end
    # Leave the method if the check fails.
    unless output_data.valid?
      self.restor_ignored_fields(output_data.update?)
      return false
    end
    #
    data : Hash(String, DynFork::Globals::ResultMapType) = output_data.data
    # Create or update a document in the database.
    if output_data.update?
      # Update doc.
      data["updated_at"] = Time.utc
      # Run hook.
      self.pre_update
      if doc : BSON? = collection.find_one_and_update(
           filter: {_id: data["_id"]},
           update: {"$set": data},
           new: true
         )
        # Run hook.
        self.post_update
        self.refrash_fields(pointerof(doc))
      end
    else
      # Create doc.
      datetime : Time = Time.utc
      data["created_at"] = datetime
      data["updated_at"] = datetime
      # Run hook.
      self.pre_create
      # Insert doc.
      collection.insert_one(data)
      # Run hook.
      self.post_create
      if doc = collection.find_one({_id: data["_id"]})
        self.refrash_fields(pointerof(doc))
      else
        raise DynFork::Errors::Panic.new(
          "Model : `#{@@full_model_name}` => The document was not created."
        )
      end
    end
    #
    true
  end
end
