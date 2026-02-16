class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @following = current_user.friends # Puxa do seu has_many :friends [cite: 12]
    @followers = current_user.followers # Puxa do seu has_many :followers [cite: 15]
  end

  def search
    if params[:nickname].present?
      @users = User.where("nickname LIKE ?", "%#{params[:nickname]}%").where.not(id: current_user.id)
    else
      @users = []
    end
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to friends_path, notice: "[CONNECTION_ESTABLISHED]"
    else
      redirect_to friends_search_path, alert: "[LINK_FAILURE]"
    end
  end


  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    redirect_to friends_path, notice: "[CONNECTION_TERMINATED]"
  end
end
