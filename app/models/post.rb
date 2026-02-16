class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  # Active Storage para a imagem de capa
  has_one_attached :cover_image
  
  # Action Text para o conteúdo rico (suporta anexos e formatação)
  has_rich_text :content
  
  validates :title, presence: true
  validates :cover_image, content_type: [:png, :jpg, :jpeg], size: { less_than: 5.megabytes }
end
