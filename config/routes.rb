Rails.application.routes.draw do
  get 'friends', to: 'friends#index'
get 'friends/search', to: 'friends#search'
resources :friendships, only: [:create, :destroy]
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
  resources :chats, only: [:index, :show, :create] do
    # Adicionamos :edit e :update para habilitar o edit_chat_message_path
    resources :messages, only: [:create, :edit, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
