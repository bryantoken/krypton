class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end
    add_index :chats, :sender_id
    add_index :chats, :receiver_id
    # Garante que não existam chats duplicados entre as mesmas duas pessoas
    add_index :chats, [:sender_id, :receiver_id], unique: true
  end
end
