class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.text :body
      t.text :encrypted_body
      t.integer :parent_id

      t.timestamps
    end
  end
end
