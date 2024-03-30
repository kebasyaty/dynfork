module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new(
      unique: true
    )
    getter avatar = DynFork::Fields::ImageField.new(
      default: "assets/media/default/no_photo.jpeg",
      thumbnails: [{"xs", 40}, {"sm", 80}, {"md", 120}, {"lg", 160}]
    )
    getter resume = DynFork::Fields::FileField.new(
      default: "assets/media/default/no_doc.odt",
    )
  end
end
