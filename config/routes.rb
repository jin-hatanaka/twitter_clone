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
  resources :tweets
  resources :profiles, only: %i[index edit]
end
