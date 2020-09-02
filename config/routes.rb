Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get "/find", to: "search#show"
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
      get "/items/:id/merchant", to: "items#merchant"

      namespace :merchants do
        get "/find", to: "search#index"
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      get "/merchants/:id/items", to: "merchants#items"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
