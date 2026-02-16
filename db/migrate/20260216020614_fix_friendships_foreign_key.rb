class FixFriendshipsForeignKey < ActiveRecord::Migration[8.0]
  def change
    # Remove a chave estrangeira antiga que procura a tabela 'friends'
    remove_foreign_key :friendships, column: :friend_id

    # Adiciona a nova chave estrangeira apontando explicitamente para 'users'
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
