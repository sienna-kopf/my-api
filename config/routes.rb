Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]

      get "/merchants/:id/items", to: "merchants#items"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
