Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  root to: "home#index"
  
  devise_for :users do
    get "/users/sign_out" => "devise/sessions#destroy"
    delete "/users/sign_out" => "devise/sessions#destroy"
  end
  
  get "/404", to: "errors#not_found"
  get "/not_found", to: "errors#not_found"
  get "/items/search", to: "items#search"
  get "/skins/search", to: "skins#search"
  
  resources :stats, only: [:index] do
    collection do
      get :totals
    end
  end
  
  resources :search, only: [:index] do
    collection do
      get "/sales", to: "search#sales"
      get "/purchases", to: "search#purchases"
      get "/steam_trades", to: "search#steam_trades"
      get "/marketplace", to: "search#marketplace_sales"
      get "/marketplace/sales", to: "search#marketplace_sales"
      get "/steam_trades/sales", to: "search#steam_trades_sales"
      get "/steam_trades/purchases", to: "search#steam_trades_purchases"
      get "/market_listings/sales", to: "search#market_listings_sales"
      get "/market_listings/purchases", to: "search#market_listings_purchases"
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
