class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  
  # Suporte para Respostas (Replies)
  belongs_to :parent, class_name: "Message", optional: true
  has_many :replies, class_name: "Message", foreign_key: "parent_id", dependent: :destroy

  # Suporte para Anexos (Active Storage)
  has_many_attached :attachments

  # Validações
  validates :body, presence: true, unless: -> { attachments.attached? }

  # Lógica de Edição/Deleção (Limite de 1 hora)
  def authorized_to_modify?
    created_at > 1.hour.ago
  end
  # app/models/message.rb (dentro da classe)
def encrypted_body
  crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secret_key_base[0..31])
  crypt.encrypt_and_sign(self.body)
end

def decrypted_body(encrypted_data)
  crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secret_key_base[0..31])
  crypt.decrypt_and_verify(encrypted_data)
end
end
