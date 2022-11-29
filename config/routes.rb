Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # test
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users do
    resources :responses, only: [:index]
  end
  resources :assessments do
    resources :responses, only: [:index, :new, :create]
  end
  resources :responses, only: [:show, :edit, :update, :destroy]
end
