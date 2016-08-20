Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "welcome#index"

  get "/about" => "welcome#about", as: :about

  get "/services" => "welcome#services", as: :services

  get "/contact" => "contact#contact", as: :contact
  post "/contact" => "contact#create", as: :create

  # resources :products, only: [:new, :create, :edit, :update] #this is for TDD controller
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end
  resources :products do
    resources :reviews, only: [:create, :destroy]
  end


  root "welcome#index"
end
