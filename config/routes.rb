Rails.application.routes.draw do
  resources :posts do
    # Isso cria a rota post_comments_path(@post)
    resources :comments, only: [:create]
    resources :likes, only: [:create]
    delete 'likes/:id', to: 'likes#destroy', as: :like
    
    # Aproveite para adicionar a rota de likes se for fazer depois
  end
  get "home/index"
  devise_for :users
  resources :users, only: [:show]

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
