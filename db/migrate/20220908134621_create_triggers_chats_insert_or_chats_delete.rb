# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersChatsInsertOrChatsDelete < ActiveRecord::Migration[5.1]
  def up
    create_trigger("chats_after_insert_row_tr", :generated => true, :compatibility => 1).
        on("chats").
        after(:insert) do
      "UPDATE applications SET chats_count = chats_count + 1 WHERE applications.id = NEW.application_id;"
    end

    create_trigger("chats_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("chats").
        after(:delete) do
      "UPDATE applications SET chats_count = chats_count - 1 WHERE applications.id = OLD.application_id;"
    end
  end

  def down
    drop_trigger("chats_after_insert_row_tr", "chats", :generated => true)

    drop_trigger("chats_after_delete_row_tr", "chats", :generated => true)
  end
end
