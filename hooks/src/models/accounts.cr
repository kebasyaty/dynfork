module Models::Accounts
  @[DynFork::Meta(service_name: "Accounts")]
  struct User < DynFork::Model
    getter username = DynFork::Fields::TextField.new
    getter email = DynFork::Fields::EmailField.new
    getter birthday = DynFork::Fields::DateField.new

    private def pre_create
      puts "!!!-pre_create-!!!"
    end

    private def post_create
      puts "!!!-post_create-!!!"
    end

    private def pre_update
      puts "\n!!!-pre_update-!!!"
    end

    private def post_update
      puts "!!!-post_update-!!!"
    end

    private def pre_delete
      puts "\n!!!-pre_delete-!!!"
    end

    private def post_delete
      puts "!!!-post_delete-!!!\n\n"
    end
  end
end
