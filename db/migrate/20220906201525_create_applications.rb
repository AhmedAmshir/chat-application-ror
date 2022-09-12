class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token
      t.integer :chats_count

      t.timestamps
    end

    add_index :applications, :token
    change_column_default :applications, :chats_count, 0

  end
end
