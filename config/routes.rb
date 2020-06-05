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
      get :search
      
      get '/search/sales', to: 'stats#sales'
      get '/search/purchases', to: 'stats#purchases'
      get '/search/steam_trades', to: 'stats#steam_trades'
      get '/search/marketplace', to: 'stats#marketplace_sales'
      get '/search/marketplace/sales', to: 'stats#marketplace_sales'
      get '/search/steam_trades/sales', to: 'stats#steam_trades_sales'
      get '/search/steam_trades/purchases', to: 'stats#steam_trades_purchases'
      get '/search/market_listings/sales', to: 'stats#market_listings_sales'
      get '/search/market_listings/purchases', to: 'stats#market_listings_purchases'
      get :totals
    end
  end
  
  resources :bots, only: [:index, :show] do
    resources :steam_trades  
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
