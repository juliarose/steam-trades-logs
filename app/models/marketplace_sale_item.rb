class MarketplaceSaleItem < ApplicationRecord
  extend MarketplaceSkuParser
  
  monetize :price, as: :price_money
  
  belongs_to :marketplace_sale
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone
    
    parsed = self.parse_sku(data['sku'], data['name'])
    
    # add the parsed item to the data
    data.merge!(parsed.stringify_keys)
    
    # map related keys to column names
    {
      'name' => 'full_name',
      'id' => 'item_id',
      'original_id' => 'item_original_id'
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !MarketplaceSaleItem.column_names.include?(key)
    end
    
    MarketplaceSaleItem.new(data)
  end
end
