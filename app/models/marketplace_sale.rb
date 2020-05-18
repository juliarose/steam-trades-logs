require "date"
require "net/http"

class MarketplaceSale < ApplicationRecord
  monetize :earned_credit, as: :earned_credit_money
  
  validates :transaction_id, :uniqueness => { :case_sensitive => true }
  has_many :marketplace_sale_items, dependent: :destroy
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone.deep_symbolize_keys
    
    # map related keys to column names
    {
      :id => :transaction_id,
      :time => :date,
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # convert date timestamp to date
    data[:date] = Time.at(data[:date]).to_datetime
    
    # get the items before they are stripped from data
    items = data[:items]
    
    # delete non-column keys before creating our record
    data = data.except(:id).delete_if do |key, value|
      !MarketplaceSale.column_names.include?(key.to_s)
    end
    
    marketplace_sale = MarketplaceSale.new(data)
    
    marketplace_sale_items = items.map do |item|
      MarketplaceSaleItem.from_json(item)
    end
    
    marketplace_sale_items.each do |marketplace_sale_item|
      # build the item onto the trade
      marketplace_sale.marketplace_sale_items.build(marketplace_sale_item.attributes)
    end
    
    marketplace_sale
  end
  
  def self.get_new_sales
    stored_transaction_ids = MarketplaceSale.select("transaction_id").map(&:transaction_id)
    
    # reject sales we've already stored
    self.get_recent_sales.reject do |marketplace_sale|
      stored_transaction_ids.include?(marketplace_sale.transaction_id)
    end
  end
  
  def self.get_recent_sales
    # take the most recent sale from the database
    most_recent_marketplace_sale = MarketplaceSale.order("date DESC").first
    # we want get results up until the time of the last sale (minus 2 days too account for items pending review)
    until_time = most_recent_marketplace_sale ? most_recent_marketplace_sale.date.to_i - 2.days.to_i : 0
    
    self.get_sales(until_time)
  end
  
  def self.request_sales(params)
    response = Requests.get("https://marketplace.tf/api/Seller/GetSales/v2", {
      :key => ENV["MARKETPLACE_API_KEY"]
    }.merge(params))
    
    # take the sales from the response body
    JSON.parse(response.body).deep_symbolize_keys[:sales]
  end
  
  def self.get_sales(until_time = 0, page_size = 500)
    # get the first page of results
    sales = self.request_sales({
      :num => page_size
    })
    last_fetched_time = nil
    
    # no sales
    if sales.length === 0
      return []
    end
    
    # this will fetch results until the specified time
    # or the date of the previous last fetched time is the same as the time of the last sale,
    # meaning we have reached the end of the results
    # or the number of sales was less than the page size used,
    # which means we have fewer sales than the page size
    until sales.last[:time] <= until_time || last_fetched_time == sales.last[:time] || sales.length < page_size
      last_fetched_time = sales.last[:time]
      # get another page and add the sales from this page
      sales += self.request_sales({
        :num => page_size,
        # get results occuring before the last fetched sale
        :start_before => last_fetched_time
      })
      
      # space requests n seconds apart from eachother
      sleep 2
    end
    
    # no duplicates
    # paid sale occurring after time and not already stored in database
    sales
      .uniq { |sale| sale[:id] }
      .select { |sale| sale[:paid] && sale[:time] > until_time }
      .map { |sale| MarketplaceSale.from_json(sale) }
  end
end
