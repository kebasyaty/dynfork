# Dynamic Unit Management.
module DynFork::Commons::Unit
  extend self

  # For manage dynamic units (add or delete).
  # NOTE: Management for `choices` parameter in dynamic field types.
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
  def manager_dyn_unit(dyn_unit : DynFork::Globals::DynUnit)
    # ...
  end
end
