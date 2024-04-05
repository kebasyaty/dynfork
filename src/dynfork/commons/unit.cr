# Dynamic Unit Management.
module DynFork::Commons::Unit
  # For manage dynamic units (add or delete).
  # NOTE: The main use is to check data from web forms.
  #
  # Example:
  # ```
  # @[DynFork::Meta(service_name: "Accounts")]
  # struct User < DynFork::Model
  #   getter username = DynFork::Fields::TextField.new
  #   getter birthday = DynFork::Fields::DateField.new
  # end
  #
  # dyn_unit = DynFork::Globals::DynUnit.new(
  #   field_name: "field_name",
  #   title: "Title",
  #   value: "value", # String | Int64 | Float64
  #   delete: false   # default is the same as false
  # )
  #
  # User.manager_dyn_unit dyn_unit
  # ```
  #
  def self.manager_dyn_unit(dyn_unit : DynFork::Globals::DynUnit)
    # ...
  end
end
