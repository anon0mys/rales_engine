Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random.json', to: 'random#show'
      end

      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random.json', to: 'random#show'
      end

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random.json', to: 'random#show'
      end

      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/random.json', to: 'random#show'
      end

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/revenue', to: 'revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/random.json', to: 'random#show'
      end

      namespace :transactions do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random.json', to: 'random#show'
      end

      resources :customers, except: %i[new edit] do
        get '/transactions', to: 'customers/transactions#index'
        get '/invoices', to: 'customers/invoices#index'
      end

      resources :invoice_items, except: %i[new edit] do
        get '/item', to: 'invoice_items/items#show'
        get '/invoice', to: 'invoice_items/invoices#show'
      end

      resources :invoices, except: %i[new edit] do
        get '/transactions', to: 'invoices/transactions#index'
        get '/invoice_items', to: 'invoices/invoice_items#index'
        get '/items', to: 'invoices/items#index'
        get '/customer', to: 'invoices/customers#show'
        get '/merchant', to: 'invoices/merchants#show'
      end

      resources :items, except: %i[new edit] do
        get '/invoices', to: 'items/invoices#index'
        get '/invoice_items', to: 'items/invoice_items#index'
        get '/merchant', to: 'items/merchants#show'
        get '/best_day', to: 'items/best_day#show'
      end

      resources :merchants, except: %i[new edit] do
        get '/items', to: 'merchants/items#index'
        get '/invoices', to: 'merchants/invoices#index'
        get '/revenue', to: 'merchants/revenue#show'
        get '/favorite_customer', to: 'merchants/favorite_customers#show'
      end

      resources :transactions, exept: %i[new edit] do
        get '/invoice', to: 'transactions/invoices#show'
      end

    end
  end
end
