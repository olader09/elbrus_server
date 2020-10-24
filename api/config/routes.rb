require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  post :user_token, to: 'user_token#create'
  resource :user

  post :superuser_token, to: 'superuser_token#create'
  resource :superuser do
    get 'show_user/:id', to: 'superusers#show_user', on: :member
    put 'update_user/:id', to: 'superusers#update_user', on: :member
    get :index_users, on: :member
  end

  resources :events

  
end
