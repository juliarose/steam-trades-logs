require 'date'

class MarketplaceSale < ApplicationRecord
  
  monetize :earned_credit, as: :earned_credit_money
  
  validates :transaction_id, :uniqueness => { :case_sensitive => true }
  has_many :marketplace_sale_items, dependent: :destroy
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone
    
    # map related keys to column names
    {
      'id' => 'transaction_id',
      'time' => 'date',
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # convert date timestamp to date
    data['date'] = Time.at(data['date']).to_datetime
    
    items = data['items']
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !self.column_names.include?(key)
    end
    
    marketplace_sale = MarketplaceSale.new(data)
    
    marketplace_sale_items = items.map do |item|
      MarketplaceSaleItem.from_json(item)
    end
    
    marketplace_sale_items.each do |marketplace_sale_item|
      # build the item onto the trade
      marketplace_sale.marketplace_sale_items.build(marketplace_sale_item.attributes.except('id'))
    end
    
    marketplace_sale
  end
end
