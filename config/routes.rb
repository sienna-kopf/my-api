Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]

      get "/merchants/:id/items", to: "merchants#items"
      get "/items/:id/merchant", to: "items#merchant"

      get "/items/find", to: "items#find"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
