Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :customers, only: [:index,:show] do
        get :favorite_merchant
        get :invoices
        get :transactions

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :invoices, only: [:index,:show] do
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

      resources :invoice_items, only: [:index,:show] do
        get :invoice
        get :item

        collection do
          get :random
          get :find_all
          get :find
        end
      end

      resources :items, only: [:index,:show] do
        get :invoice_items
        get :merchant
        get :best_day

        collection do
          get :most_items
          get :most_revenue
          get :random
          get :find_all
          get :find
        end
      end

      resources :merchants, only: [:index,:show] do
        get :items
        get :invoices
        get :revenue
        get :favorite_customer
        get :customers_with_pending_invoices

        collection do
          get :revenue
          get :most_items
          get :most_revenue
          get :random
          get :find_all
          get :find
        end
      end

      resources :transactions, only: [:index,:show] do
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
