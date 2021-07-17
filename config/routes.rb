Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index, :show]
      resources :items

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
