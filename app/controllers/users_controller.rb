class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # Carrega os posts ordenados pelos mais recentes
    @posts = @user.posts.order(created_at: :desc)
  end
end
