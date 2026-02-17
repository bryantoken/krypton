class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat
  before_action :set_message, only: [:edit, :update, :destroy]

  def create
    @message = @chat.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to chat_path(@chat)
    else
      redirect_to chat_path(@chat), alert: "[SIGNAL_ERROR]"
    end
  end

  def edit
    # Verificar se ainda pode editar (< 1 hora)
    unless @message.authorized_to_modify?
      redirect_to chat_path(@chat), alert: "[ACCESS_DENIED_TIME_EXPIRED]"
    end
  end

  def update
    if @message.authorized_to_modify? && @message.update(message_params)
      redirect_to chat_path(@chat), notice: "[LOG_UPDATED]"
    else
      redirect_to chat_path(@chat), alert: "[MODIFICATION_FAILURE]"
    end
  end
  
  def destroy
    if @message.authorized_to_modify?
      @message.destroy
      redirect_to chat_path(@chat), notice: "[LOG_DELETED]"
    else
      redirect_to chat_path(@chat), alert: "[ACCESS_DENIED_TIME_EXPIRED]"
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    # Buscar mensagem dentro do chat
    @message = @chat.messages.find(params[:id])
    
    # Verificar se o usuário é o dono da mensagem
    unless @message.user == current_user
      redirect_to chat_path(@chat), alert: "[ACCESS_DENIED]"
    end
  end

  def message_params
    params.require(:message).permit(:body, :parent_id)
  end
end
