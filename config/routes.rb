Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'find#show'
      end
      resources :invoices, except: [:new, :edit]
      resources :merchants, except: %i[new edit] do
        get '/items', to: 'merchants/items#index'
      end
    end
  end
end
