# Creating and updating documents in the database.
module DynFork::Paladins::Save
  # Creating and updating documents in the database.
  # <br>
  # This method pre-uses the _check_ method.
  def save
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
    return unless output_data.valid?
    # Create or update a document in the database.
    if output_data.update?
      # Create doc.
      collection.insert_one(output_data.data)
    else
      # Update doc.
      if hash : BSON::ObjectId? = @hash.object_id?
        filter = {"_id": hash}
        update = {"$set": output_data.data}
        collection.update_one(filter, update)
      else
        raise DynFork::Errors::Panic.new(
          "Model : `#{self.model_name}` > Field: `hash` > " +
          "Param: `value` => Hash is missing."
        )
      end
    end
  end
end
