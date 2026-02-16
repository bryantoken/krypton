class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Transmite o novo comentário para o final da lista de comentários
  after_create_commit { broadcast_append_to "comments_post_#{post.id}", target: "comments_list_#{post.id}" }
end
