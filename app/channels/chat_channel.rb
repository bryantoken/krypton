class ChatChannel < ApplicationCable::Channel
  def subscribed
    # Cria um canal específico para cada chat baseado no ID
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    # Qualquer limpeza necessária quando o usuário desconectar
  end
end
