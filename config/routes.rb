# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :books
  # resources :ocrtrackers
  root to: 'dashboards#show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  get 'submissions/new/:workout_post_id', to: 'submissions#new'
  post 'submissions/create', to: 'submissions#create'

  get 'submissions/history/:workout_post_id', to: 'submissions#history'

  get 'posts/new/', to: 'posts#new'
  post 'posts/create/', to: 'posts#create'

  # Admin-only routes for setting WOD dates
  get '/wod/set', to: 'wod#index', as: 'set_wod'
  post '/wod/set', to: 'wod#update_wod'
  post '/wod/remove/:workout_post_id', to: 'wod#remove', as: 'remove_wod'

  # User route for viewing the current WOD
  get '/wod/current', to: 'wod#show_current_wod'
  get '/wod/history', to: 'wod#show_wod_history', as: 'wod_history'



  resources :exercises#, :workout_posts, :exercise_posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
