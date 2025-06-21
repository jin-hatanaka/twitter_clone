# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'profiles/index'
  # get 'profiles/edit'
  # get 'tweets/index'
  # get 'tweets/show'
  # get 'tweets/new'
  # get 'tweets/edit'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'tweets#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resources :tweets do
    resources :comments, only: [:create]
    resource :likes, only: %i[create destroy]
    resource :retweets, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
  end
  resources :profiles
  resources :users do
    resource :relationships, only: %i[create destroy]
    resources :rooms, only: [:create]
  end
  resources :bookmarks, only: [:index]
  resources :rooms, only: [:index] do
    resources :messages, only: [:create]
  end
end
