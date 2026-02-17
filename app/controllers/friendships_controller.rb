class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    
    if @friendship.save
      redirect_back fallback_location: root_path, notice: "[CONNECTION_ESTABLISHED]"
    else
      redirect_back fallback_location: root_path, alert: "[LINK_FAILURE]"
    end
  end

  def destroy
    # Tenta encontrar a amizade pelo ID da relação ou pelo ID do amigo
    @friendship = current_user.friendships.find_by(id: params[:id])
    @friendship ||= current_user.friendships.find_by(friend_id: params[:id])

    if @friendship
      @friendship.destroy
      redirect_back fallback_location: root_path, notice: "[CONNECTION_TERMINATED]"
    else
      redirect_back fallback_location: root_path, alert: "[SIGNAL_NOT_FOUND]"
    end
  end # fecha o def destroy
end # fecha a class FriendshipsController
