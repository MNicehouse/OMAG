Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'options/new'
  get 'assessments/new'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :assessments
  # Defines the root path route ("/")
  # root "articles#index"

  resources :questions do
    resources :options, only: %i[new create]
  end

  resources :users do
    resources :responses, only: [:index]
    # resources :assessments, only: %i[new create]
  end
  resources :assessments do
    resources :responses, only: [:index, :new, :create]
  end
  resources :responses, only: [:show, :edit, :update, :destroy]
end
