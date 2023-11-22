module Crymon
  # Methods that are called at different stages when accessing the database.
  abstract struct Hooks
    # Called before a new document is created in the database.
    def pre_create; end

    # Called after a new document has been created in the database.
    def post_create; end

    # Called before updating an existing document in the database.
    def pre_update; end

    # Called after an existing document in the database is updated.
    def post_update; end

    # Called before deleting an existing document in the database.
    def pre_delete; end

    # Called after an existing document in the database has been deleted.
    def post_delete; end
  end
end
