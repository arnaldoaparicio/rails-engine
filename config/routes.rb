Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/items/find_all', to: 'api/v1/item_search#index'
  get '/api/v1/merchants/find_all', to: 'api/v1/merchant_search#index'
  get '/api/v1/items/find', to: 'api/v1/item_search#show'
  get '/api/v1/merchants/find', to: 'api/v1/merchant_search#show'
  
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end

  get '/api/v1/items/:item_id/merchant', to: 'api/v1/merchants#index'
end
