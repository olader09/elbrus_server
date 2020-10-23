require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  post :user_token, to: 'user_token#create'
  resource :user

  post :superuser_token, to: 'superuser_token#create'
  resource :superuser

  resources :events

  
end
