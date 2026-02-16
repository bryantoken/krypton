class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Tenta encontrar um chat existente ou cria um novo entre os dois agentes
    @chat = Chat.between(current_user.id, params[:receiver_id]).first_or_create do |chat|
      chat.sender_id = current_user.id
      chat.receiver_id = params[:receiver_id]
    end

    redirect_to chat_path(@chat)
  end

  def show
    @chat = Chat.find(params[:id])
    # Define quem é o outro agente na conversa
    @other_user = @chat.sender == current_user ? @chat.receiver : @chat.sender
    # Carrega o histórico de transmissões
    @messages = @chat.messages.order(created_at: :asc)
  end
end
