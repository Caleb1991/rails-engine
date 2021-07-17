Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/:page_number/:limit', to: 'merchants#index', defaults: { page_number: 1, limit: 20 }
      get '/items/:page_number/:limit', to: 'items#index', defaults: { page_number: 1, limit: 20 }

      resources :merchants, only: :show
      resources :items

      namespace :item do
        scope '/:id', :as => 'item' do
          resources :merchant, only: :show
        end
      end
      
      namespace :merchant do
        scope '/:id', :as => 'merchant' do
          resources :items, only: :index
        end
      end
    end
  end
end
