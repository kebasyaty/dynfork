# Additional methods for Model validation.
module Crymon::Paladins::CheckPlus
  # Check data validity.
  # NOTE: The main use is to check data from web forms.
  #
  # Example:
  # ```
  # @[Crymon::Meta(service_name: "Accounts")]
  # struct User < Crymon::Model
  #   getter username = Crymon::Fields::TextField.new
  #   getter birthday = Crymon::Fields::DateField.new
  # end
  #
  # user = User.new
  # if user.valid?
  #   # your code...
  # end
  # ```
  #
  def valid? : Bool
    # Get the collection for the current model.
    collection : Mongo::Collection = Crymon::Globals.cache_mongo_database.not_nil![
      @@meta.not_nil![:collection_name]]
    self.check(pointerof(collection)).is_valid?
  end

  # Printing errors to the console ( for development ).
  #
  # Example:
  # ```
  # @[Crymon::Meta(service_name: "Accounts")]
  # struct User < Crymon::Model
  #   getter username = Crymon::Fields::TextField.new
  #   getter birthday = Crymon::Fields::DateField.new
  # end
  #
  # user = User.new
  # user.print_err unless user.valid?
  # ```
  #
  def print_err
    msg : String = ""
    errors : String = ""
    {% for field in @type.instance_vars %}
      unless @{{ field }}.errors.empty?
        (msg = "\n## ERRORS:") if msg.empty?
        errors = @{{ field }}.errors.copy.map { |err| "\t#{err}" }.join("\n")
        msg = "#{msg}\n# #{{{ field.name.stringify }}}: #{errors}"
      end
    {% end %}
    line_break : String = msg.empty? ? "\n" : "\n\n"
    (msg + "#{line_break}## AlERTS:\n#{@hash.alerts.join("\n")}") unless @hash.alerts.empty?
    (msg + "\n") unless msg.empty?
    puts msg
  end

  # For accumulating errors.
  def accumulate_error(
    err_msg : String,
    field_ptr : Pointer,
    is_error_symptom_ptr? : Pointer(Bool)
  )
    if !field_ptr.value.is_hide?
      field_ptr.value.errors << err_msg
      (is_error_symptom_ptr?.value = true) unless is_error_symptom_ptr?.value
    else
      msg = ">hidden field< - Model: `#{@@meta.not_nil![:model_name]}` > " +
            "Field: `#{field_ptr.value.name}` => #{err_msg}"
      raise Crymon::Errors::Panic.new msg
    end
  end

  # For fill in all fields of the slug type.
  def create_slugs
    # ...
  end
end
