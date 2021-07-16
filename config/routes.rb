Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/:page_number/:limit', to: 'merchants#index', defaults: { limit: 20 }
      get '/items/:page_number/:limit', to: 'items#index', defaults: { limit: 20 }

      resources :merchants, only: :show
      resources :items

      namespace :merchant do
        scope '/:id', :as => 'merchant' do
          resources :items, only: :index
        end
      end
    end
  end
end
