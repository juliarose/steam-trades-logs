Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: "home#index"
  
  devise_for :users
  
  resources :sales, only: [:index] do
    collection do
      get :steam_trades
      get :market_listings
      get :marketplace_sales
    end
  end
  
  resources :purchases, only: [:index] do
    collection do
      get :steam_trades
      get :market_listings
    end
  end
  
  resources :stats, only: [:index] do
    collection do
      get "item/:full_name", action: :item
      get :totals
    end
  end
  
  resources :key_values
  resources :market_listings
  resources :steam_trades
  resources :steam_trade_items
  resources :usd_values
  resources :scm_values
  resources :marketplace_sales
  resources :marketplace_sale_items
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
