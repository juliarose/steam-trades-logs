class UpdateMarketplaceSalesJob < ApplicationJob
  
  def perform
    MarketplaceSale.get_recent_sales.each(&:save)
  end
end