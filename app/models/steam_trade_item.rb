class SteamTradeItem < ApplicationRecord
  include SteamItem
  include LogItem
  
  belongs_to :steam_trade
  has_one :item,
    :foreign_key => :defindex,
    :primary_key => :defindex
  
  scope :received_items, -> { where(is_their_item: true) }
  scope :given_items, -> { where(is_their_item: false) }
  
  def bptf_price
    BptfPrice.where({
      :quality_id => self.quality_id,
      :priceindex => self.particle_id,
      :craftable => self.craftable,
      :australium => self.australium,
      :defindex => self.defindex
    }).first
  end
  
  # not all data is formatted in the same manner,
  # some may be missing values or use a differenf format
  # but this should parse across all formats
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone.deep_symbolize_keys
    
    # get the most descriptive name for this item
    name = data[:full_name] || data[:market_hash_name] || data[:market_name]
    
    # we want these as integers
    data[:appid] = data[:appid].to_i if data[:appid]
    data[:contextid] = data[:contextid].to_i if data[:contextid]
    
    # this is used for finding the associated item in the schema for this item
    # since we also want to include an item_name property for our items
    defindex = data[:appdata][:defindex] if data[:appdata] && data[:appid] == 440
    
    # get the name of the skin
    parsed = ItemParser.parse_name(name, defindex)
    
    unless parsed.nil?
      # merge the keys from the parsed item
      data.merge!(parsed.stringify_keys)
    end
    
    unless data[:appdata].nil?
      # add the appdata to the original object
      data.merge!(data[:appdata])
    end
    
    unless data[:full_name]
      # just use what name we could get
      data[:full_name] = name
    end
    
    # map related keys to column names
    {
      :quality => :quality_id,
      :particle => :particle_id,
      :wear => :wear_id,
      :killstreak_tier => :killstreak_tier_id,
      :priceindex => :particle_id
    }.each do |k, v|
      data[v] = data[k] unless data[k].nil?
    end
    
    if data[:priceindex] === 0
      # make 0 values null
      data[:priceindex] = nil
    end
    
    # delete non-column keys before creating our record
    data = data.except(:id).delete_if do |key, value|
      !SteamTradeItem.column_names.include?(key.to_s)
    end
    
    SteamTradeItem.new(data)
  end
end
