# app/controllers/friendships_controller.rb
class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Tenta criar a amizade com o ID do alvo vindo do parâmetro
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    
    if @friendship.save
      redirect_back fallback_location: root_path, notice: "[CONNECTION_ESTABLISHED]"
    else
      redirect_back fallback_location: root_path, alert: "[LINK_FAILURE]"
    end
  end

  def destroy
    # Busca a amizade para encerrar a conexão
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    if @friendship
      @friendship.destroy
      redirect_back fallback_location: root_path, notice: "[CONNECTION_TERMINATED]"
    end
  end
end
