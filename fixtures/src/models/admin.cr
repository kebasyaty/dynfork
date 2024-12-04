module Models::Admin
  @[DynFork::Meta(
    service_name: "Admin",
    fixture_name: "SiteSettings",
    migrat_model?: true,
    create_doc?: false,
    update_doc?: true,
    delete_doc?: false,
  )]
  struct SiteSettings < DynFork::Model
    getter logo = DynFork::Fields::ImageField.new(
      default: "public/media/default/no_photo.jpeg",
      thumbnails: [{"xs", 40}, {"sm", 80}, {"md", 120}, {"lg", 160}]
    )
    getter brand = DynFork::Fields::TextField.new
    getter slogan = DynFork::Fields::TextField.new
    getter meta_title = DynFork::Fields::TextField.new
    getter meta_description = DynFork::Fields::TextField.new
    getter contact_email = DynFork::Fields::EmailField.new
  end
end
