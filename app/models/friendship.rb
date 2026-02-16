class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User" # Adicione class_name aqui também
end
