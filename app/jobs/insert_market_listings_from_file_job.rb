class InsertMarketListingsFromFileJob < ApplicationJob
  
  def perform(filepath)
    # get array of all keys stored in database
    market_listing_transaction_ids = MarketListing.select("transaction_id").all.map(&:transaction_id)
    
    # we group records into clusters to save in transactions
    # this keeps memory down while saving some speed
    cluster = Array.new
    
    # these files can be quite large so we process these line-by-line
    # doing all-at-once can cause us to run out of memory
    IO.readlines(filepath, chomp: true).each do |line|
      # skip blank lines
      next if line.strip.empty?
      
      json = JSON.parse(line).deep_symbolize_keys
      
      # don't build data for existing listings
      unless market_listing_transaction_ids.include?(json[:transaction_id])
        cluster << MarketListing.from_json(json)
      end
      
      # once the cluster has reached this size, add the records
      if cluster.length >= 500
        MarketListing.import cluster, validate: true
        
        # reset the cluster
        cluster = Array.new
      end
    end
    
    if cluster.length > 0
      # save remaining objects
      MarketListing.import cluster, validate: true
    end
  end
end