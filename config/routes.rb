Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :restaurants do
    resources :dishes, only: [:new, :create]
  end
 resources :dishes, except: [:new, :create]


  get "my_restaurants", to: "restaurants#my_restaurants", as: :my_restaurants
end
