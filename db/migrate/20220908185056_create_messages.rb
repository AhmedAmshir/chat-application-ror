class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :number
      t.text :body
      t.references :chat, foreign_key: true, type: :bigint

      t.timestamps
    end

    add_index :messages, :number

  end
end
