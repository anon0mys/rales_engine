Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :invoices, except: [:new, :edit]
      resources :merchants, except: %i[new edit] do
        resources :items, only: [:index]
      end
    end
  end
end
