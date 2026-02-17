class HomeController < ApplicationController
  # Permite que visitantes vejam o feed sem deslogar
  before_action :authenticate_user!, except: [:index]

  def index
    # Público: Posts centrais
    @posts = Post.all.order(created_at: :desc).limit(10)
    
    if user_signed_in?
      # Carrega dados reais para usuários logados
      @recent_messages = current_user.messages.order(created_at: :desc).limit(5) || []
      @recent_followers = current_user.followers.order(created_at: :desc).limit(8) || []
      @nodes = User.where.not(id: current_user.id).limit(15) || []
    else
      # Inicializa como arrays vazios para evitar erro 'nil' na View
      @recent_messages = []
      @recent_followers = []
      @nodes = []
    end
  end
end
