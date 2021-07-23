Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#search'
      get '/merchants/most_items', to: 'merchants#most_items'
      resources :merchants, only: [:index, :show]

      get '/items/find_all', to: 'items#search'
      resources :items

      namespace :revenue do
        resources :merchants, only: [:index, :show]
      end

      namespace :items do
        get '/find', to: 'items#search'
        scope '/:id', :as => 'item' do
          resources :merchant, only: :index
        end
      end

      namespace :merchants do
        scope '/:id', :as => 'merchant' do
          resources :items, only: :index
        end
      end
    end
  end
end
