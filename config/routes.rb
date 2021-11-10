# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/show'
  # resources :books
  # resources :ocrtrackers
  root to: 'dashboards#show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end

  get 'submissions/new/:workout_post_id', to: 'submissions#new', as: 'new_submission'
  get 'submissions/:id/edit/', to: 'submissions#edit', as: 'edit_submission'
  post 'submissions/create', to: 'submissions#create'

  get 'submissions/history/:workout_post_id', to: 'submissions#history', as: 'submissions_history'

  get 'posts/new/', to: 'posts#new', as: 'posts_new'
  post 'posts/create/', to: 'posts#create'

  get 'permissions/', to: 'permissions#index', as: 'permissions'
  post 'permissions/', to: 'permissions#complete'

  get 'profiles/:id/', to: 'profiles#show', as: 'profiles'
  get 'profiles/:id/edit/', to: 'profiles#edit', as: 'edit_profile'
  post 'profiles/:id/', to: 'profiles#update'


  # Admin-only routes for setting WOD dates
  get '/wod/set', to: 'wod#admin_view', as: 'set_wod'
  post '/wod/set', to: 'wod#update_wod'

  # User route for viewing the current and past WODs
  get '/wod', to: 'wod#user_view', as: 'user_wod'

  get 'leaderboard', to: 'dashboards#leaderboard'

  get 'documentation', to: 'documentation#index'

  resources :exercises#, :workout_posts, :exercise_posts
  resources :submissions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
