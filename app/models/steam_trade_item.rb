class SteamTradeItem < ApplicationRecord
  extend NameParser
  
  belongs_to :steam_trade
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone
    
    unless data['appdata'].nil?
      # add the appdata to the original object
      data.merge!(data['appdata'])
    end
    
    # get the most descriptive name for this item
    name = data['full_name'] || data['market_hash_name'] || data['market_name']
    
    # get the name of the skin
    parsed = self.parse_name(name)
    
    unless parsed.nil?
      # merge the keys from the parsed item
      data.merge!(parsed.stringify_keys)
    end
    
    # map related keys to column names
    {
      'quality' => 'quality_id',
      'particle' => 'particle_id',
      'wear' => 'wear_id',
      'killstreak_tier' => 'killstreak_tier_id'
    }.each do |k, v|
      data[v] = data[k]
    end
    
    if data['particle_id'].nil? && !data['priceindex'].zero?
      # take particle id from priceindex
      data['particle_id'] = data['priceindex']
    end
    
    # delete non-column keys before creating our record
    data.delete_if do |key, value|
      !SteamTradeItem.column_names.include?(key)
    end
    
    SteamTradeItem.new(data)
  end
end
