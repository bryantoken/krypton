class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat
  before_action :set_message, only: [:edit, :update, :destroy]

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(message_params)
    @message.user = current_user

    if @message.save
      # [VITAL]: O redirecionamento faz a página carregar a nova mensagem do banco
      redirect_to chat_path(@chat)
    else
      # Se falhar (ex: corpo vazio), volta para o chat com erro
      redirect_to chat_path(@chat), alert: "[SIGNAL_ERROR]"
    end
  end

def edit
    # O Rails vai procurar a view app/views/messages/edit.html.erb
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
      # Sucesso: LOG_DELETED
    end
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_message
    @message = current_user.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :parent_id)
  end
end
