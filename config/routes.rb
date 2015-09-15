Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :customers, only: [:show] do
        get :invoices
        get :transactions

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :invoices, only: [:show] do
        get :invoice_items
        get :transactions
        get :items
        get :customer
        get :transactions
        get :merchant

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :invoice_items, only: [:show] do
        get :invoice
        get :item

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :items, only: [:show] do
        get :invoice_items
        get :merchant

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :merchants, only: [:show] do
        get :items
        get :invoices

        collection do
          get :revenue
          get :most_items
          get :most_revenue
          get :random
          get :find_all
          get :find
        end
      end

      resources :transactions, only: [:show] do
        get :invoice

        collection do
          get :random
          get :find_all
          get :find
        end
      end

    end
  end
end
