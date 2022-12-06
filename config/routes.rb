Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :questions, only: %i[new create destroy update] do
    resources :options, only: %i[new create]
  end

  resources :users do
    resources :responses, only: %i[index]
  end

  resources :assessments, only: %i[show new create] do
    resources :responses, only: %i[index new create]
  end

  resources :responses, only: %i[show edit update destroy] do
    resources :answers, only: %i[index new create]
  end
  resources :answers, only: %i[show edit update destroy]
end
