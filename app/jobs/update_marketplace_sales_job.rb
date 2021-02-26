class UpdateMarketplaceSalesJob < ApplicationJob
  
  def perform
    # get all transaction ids
    transaction_ids = MarketplaceSale.select("transaction_id").all.map(&:transaction_id)
    # get recent sales
    marketplace_sales = MarketplaceSale.get_recent_sales
    
    marketplace_sales.each do |marketplace_sale|
      # call save on each record, except those we already have records for
      marketplace_sale.save unless transaction_ids.include? marketplace_sale.transaction_id
    end
  end
end