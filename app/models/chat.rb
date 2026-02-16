class Chat < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many :messages, dependent: :destroy

  # Esta é a lógica que a linha 13 está tentando executar
  scope :between, -> (sender_id, receiver_id) do
    where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", 
          sender_id, receiver_id, receiver_id, sender_id)
  end
end
