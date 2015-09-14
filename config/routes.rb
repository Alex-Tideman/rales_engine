Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show, :find]
      resources :invoices, only: [:index, :show, :find]
      resources :invoice_items, only: [:index, :show, :find]
      resources :items, only: [:index, :show, :find]
      resources :merchants, only: [:index, :show, :find]
      resources :transactions, only: [:index, :show, :find]
    end
  end

end
