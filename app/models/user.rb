class User < ApplicationRecord
  # Devise config 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ADICIONE ESTA LINHA:
  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Método para verificar se o usuário já deu like em um post
  def liked?(post)
    likes.exists?(post_id: post.id)
  end

  # Relacionamentos de Amizade (Network)
  has_many :friendships, dependent: :destroy
  # Especificamos que o 'friend' através de friendships é na verdade um 'User'
  has_many :friends, through: :friendships, source: :friend, class_name: "User"

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  has_many :followers, through: :inverse_friendships, source: :user

  def following?(other_user)
    friends.include?(other_user)
  end
end
