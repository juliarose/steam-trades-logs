Rails.application.routes.draw do
  resources :key_values
  resources :market_listings
  resources :steam_trades
  resources :steam_trade_items
  resources :usd_values
  resources :scm_values
  resources :trades
  resources :marketplace_sales
  resources :marketplace_sale_items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
