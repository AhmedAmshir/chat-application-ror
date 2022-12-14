class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :messages_count
      t.references :application, foreign_key: true, type: :integer

      t.timestamps
    end

    add_index :chats, :number
    change_column_default :chats, :messages_count, 0

  end
end
