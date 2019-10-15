require 'date'

class MarketListing < ApplicationRecord
  extend NameParser
  include LogItem
  
  monetize :price, as: :price_money
  
  validates :transaction_id, :uniqueness => { :case_sensitive => true }
  validates_presence_of :transaction_id,
    :transaction_id_low,
    :transaction_id_high,
    :defindex,
    :appid,
    :contextid,
    :quality_id,
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
  
  def full_icon_url(size = 62)
    dimensions = "#{size}fx#{size}f"
    
    "https://steamcommunity-a.akamaihd.net/economy/image/#{self.icon_url}/#{dimensions}"
  end
  
  def match_with_trade
    column_name = self.is_credit ? 'scm_received' : 'scm_spent'
    date_column_name = self.is_credit ? 'sold_at' : 'purchased_at'
    
    Trade.where(:full_name => self.log_name).find do |trade|
      matching_name = trade.log_name === self.log_name
      value = trade.attributes[column_name]
      date = trade.attributes[date_column_name]
      missing_data = !matching_name || value.nil? || date.nil?
      
      unless missing_data
        # get the difference of the listing's date and the date on log
        date_difference = (self.date_acted - date).to_i.abs
        
        # check that the difference is within a day
        date_difference <= 1
      end
    end
  end
  
  # converts a json object to a record
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone
    
    # map related keys to column names
    {
      'quality' => 'quality_id',
      'particle' => 'particle_id',
      'wear' => 'wear_id',
      'killstreak_tier' => 'killstreak_tier_id'
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # convert date strings to dates
    [
      'date_acted',
      'date_listed'
    ].each do |k|
      data[k] = Date.parse(data[k])
    end
    
    # split the transaction id
    split = data['transaction_id'].split('-')
    data['transaction_id_low'] = split[0]
    data['transaction_id_high'] = split[1]
    
    # get the name of the skin
    parsed = self.parse_name(json['full_name'])
    
    data['item_name'] = parsed[:item_name]
    
    if parsed[:skin_name]
      data['skin_name'] = parsed[:skin_name]
    end
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !self.column_names.include?(key)
    end
    
    MarketListing.new(data)
  end
  
  def self.batch_json(items)
    # collect all recorded transaction ids
    transaction_ids = MarketListing.all.map(&:transaction_id)
    
    # get all unrecorded items
    unrecorded_items = items.reject do |item|
      transaction_ids.include?(item['transaction_id'])
    end
    
    # collect the new records
    records = unrecorded_items.map do |json|
      self.from_json(json)
    end
    
    # return the new records
    records
  end
end
