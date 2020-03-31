require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}
  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    post 'sign_in', :to => 'devise/session#create', :as => :user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  namespace :ujs, defaults: {format: :js} do
    post 'upload', to: 'upload#create', as: 'upload_create'
    delete 'upload/:id', to: 'upload#destroy', as: 'upload_destroy'

    get 'match/:id', to: 'match#match', as: 'match'
    delete 'match/:id', to: 'match#destroy', as: 'match_destroy'

    get 'run/:id', to: 'run#start', as: 'run'
  end

  resources :run, only: [:show, :new]
  resources :show, only: [:index, :show, :destroy]
  resources :setting, only: [:index, :update, :edit, :show]

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'show#index'
end
