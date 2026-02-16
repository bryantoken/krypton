class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
validates :user_id, uniqueness: { scope: :post_id, message: "já deu like neste post" }
  
  # Atualiza o contador de likes em tempo real via WebSockets
  after_create_commit { broadcast_replace_to "likes_post_#{post.id}", target: "likes_count_#{post.id}", partial: "posts/likes_count", locals: { post: post } }
  after_destroy_commit { broadcast_replace_to "likes_post_#{post.id}", target: "likes_count_#{post.id}", partial: "posts/likes_count", locals: { post: post } }

end

