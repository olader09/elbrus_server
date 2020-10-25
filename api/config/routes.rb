require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  post :user_token, to: 'user_token#create'
  resource :user do
    put 'join_to_event/:id', to: 'users#join_to_event', on: :member
    put :close_event, on: :member
  end

  post :superuser_token, to: 'superuser_token#create'
  resource :superuser do
    get 'show_user/:id', to: 'superusers#show_user', on: :member
    put 'update_user/:id', to: 'superusers#update_user', on: :member
    get :index_users, on: :member
  end

  resources :events

  
end
