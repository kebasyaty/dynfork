# Creating and updating documents in the database.
module DynFork::Paladins::Save
  # Creating and updating documents in the database.
  # <br>
  # This method pre-uses the _check_ method.
  def save : DynFork::Globals::OutputData?
    # Get collection.
    collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
      @@meta.not_nil![:collection_name]]
    # Check and get output data.
    output_data : DynFork::Globals::OutputData = m.check(
      collection_ptr: pointerof(collection),
      save?: true
    )
    # Check the conditions and, if necessary, define a message for the web form.
    # <br>
    # Reset the alerts to exclude duplicates.
    @hash.alerts = Array(String).new
    if !output_data.update? && !@@meta.not_nil![:saving_docs?]
      @hash.alerts << I18n.t(:forbidden_saves)
      output_data.valid = false
    end
    if output_data.update? && !@@meta.not_nil![:updating_docs?]
      @hash.alerts << I18n.t(:forbidden_updates)
      output_data.valid = false
    end
    # Leave the method if the check fails.
    return output_data unless output_data.valid?
    # Create or update a document in the database.
    if output_data.update?
      # Update doc.
      if id : BSON::ObjectId? = @hash.object_id?
        filter = {"_id": id}
        update = {"$set": output_data.data}
        if doc : BSON? = collection.find_one_and_update(
             filter: filter,
             update: update,
             new: true
           )
          self.refrash_fields(doc)
        end
      else
        raise DynFork::Errors::Panic.new(
          "Model : `#{self.model_name}` > Field: `hash` > " +
          "Param: `value` => Hash is missing."
        )
      end
    else
      # Create doc.
      id : BSON::ObjectId? = @hash.object_id?
      data : BSON = (output_data.data)["_id"] = id
      collection.insert_one(data)
      if doc : BSON? = collection.find_one({_id: id})
        self.refrash_fields(doc)
      else
        raise DynFork::Errors::Panic.new(
          "Model : `#{self.model_name}` => The document was not created."
        )
      end
    end
  end
end
