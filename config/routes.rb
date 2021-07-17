Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index, :show]
      resources :items

      namespace :item do
        scope '/:id', :as => 'item' do
          resources :merchant, only: :index
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
