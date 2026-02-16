class AddUniqueIndexToLikes < ActiveRecord::Migration[8.1]
  def change
    # Remove likes duplicados existentes antes de adicionar o índice
    duplicates = Like.select(:user_id, :post_id)
                     .group(:user_id, :post_id)
                     .having('COUNT(*) > 1')
    
    duplicates.each do |dup|
      likes = Like.where(user_id: dup.user_id, post_id: dup.post_id)
      # Mantém o primeiro, remove os outros
      likes.offset(1).destroy_all
    end
    
    # Adiciona índice único
    add_index :likes, [:user_id, :post_id], unique: true, name: 'index_likes_on_user_and_post'
  end
end

