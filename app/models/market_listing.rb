require "date"

class MarketListing < ApplicationRecord
  include SteamItem
  include LogItem
  
  monetize :price, as: :price_money
  
  validates :transaction_id, :uniqueness => { :case_sensitive => true }
  validates_presence_of :transaction_id,
    :transaction_id_low,
    :transaction_id_high,
    :appid,
    :contextid,
    :date_acted,
    :date_listed,
    :market_hash_name,
    :price
  
  has_one :item,
    :foreign_key => :defindex,
    :primary_key => :defindex
  has_one :particle,
    :foreign_key => :value,
    :primary_key => :particle_id
  has_one :quality,
    :foreign_key => :value,
    :primary_key => :quality_id
  has_one :wear,
    :foreign_key => :value,
    :primary_key => :wear_id
  
  # we don't care if these are craftable or not
  def craftable
    true
  end
  
  def full_icon_url(size = 62)
    "https://steamcommunity-a.akamaihd.net/economy/image/#{self.icon_url}/#{size}fx#{size}f"
  end
  
  def image_url
    self.full_icon_url(128)
  end
  
  # gets unusual sales or purchases
  def self.sales_purchases(is_purchase, query_params = ActionController::Parameters.new)
    query_params = query_params.permit(:full_name)
    # build params for queries
    query_params = Hash.new.merge(query_params).compact
    
    MarketListing
      .includes(:item)
      .where({
        :is_credit => !is_purchase,
        :appid => 440,
        :quality_id => 5
      }.merge(query_params))
      .order("date_acted DESC")
  end
  
  # converts a json object to a record
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone.deep_symbolize_keys
    
    # convert date strings to dates
    [
      :date_acted,
      :date_listed
    ].each do |k|
      data[k] = Date.parse(data[k])
    end
    
    # split the transaction id
    split = data[:transaction_id].split("-")
    data[:transaction_id_low] = split[0]
    data[:transaction_id_high] = split[1]
    
    if data[:appid].to_i == 440
      # get the name of the skin
      parsed = ItemParser.parse_name(data[:full_name], data[:defindex])
      
      data[:item_name] = parsed[:item_name]
      
      if parsed[:skin_name]
        data[:skin_name] = parsed[:skin_name]
      end
    end
    
    # delete non-column keys before creating our record
    data = data.delete_if do |key, value|
      !MarketListing.column_names.include?(key.to_s)
    end
    
    MarketListing.new(data)
  end
end
