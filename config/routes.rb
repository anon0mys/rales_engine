Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      resources :invoices, except: %i[new edit]

      resources :items, except: %i[new edit]

      resources :invoice_items, except: %i[new edit]

      resources :merchants, except: %i[new edit] do
        get '/items', to: 'merchants/items#index'
        get '/invoices', to: 'merchants/invoices#index'
      end
    end
  end
end
