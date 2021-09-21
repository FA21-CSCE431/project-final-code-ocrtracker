Rails.application.routes.draw do
  resources :books
  resources :ocrtrackers
  root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
