Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :questions do
    resources :options, only: %i[new create]
  end

  resources :users do
    resources :responses, only: [:index]
  end
  
  resources :responses, only: [:show, :edit, :update, :destroy]
  
  resources :assessments, only: %i[new create] do
    resources :responses, only: [:index, :new, :create]
  end
end
