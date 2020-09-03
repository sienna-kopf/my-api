Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/:id/merchant", to: "merchants#index"
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]

      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/:id/items", to: "items#index", as: :merchant_items
        get "/:id/revenue", to: "revenue#show"
        get "/most_revenue", to: "revenue#index"
        get "/most_items", to: "items#most_items"
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy]

      get "/revenue", to: "revenue#show"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
