class MarketplaceSaleItem < ApplicationRecord
  include SteamItem
  include LogItem
  
  monetize :price, as: :price_money
  scope :by_most_recent, -> { includes(:marketplace_sale).order('marketplace_sales.date') }
  
  belongs_to :marketplace_sale
  has_one :item,
    :foreign_key => :defindex,
    :primary_key => :defindex
  
  # there is no appid column for items
  def appid
    # we assume this to be 440
    440
  end
  
  # gets unusual sales
  def self.sales(query_params = ActionController::Parameters.new)
    # build params for queries
    query_params = {
      # quality must be unusual or decorated weapon
      :quality_id => [5, 15]
    }.merge(query_params.permit(:full_name)).compact
    
    MarketplaceSaleItem
      .joins(:marketplace_sale)
      .includes(:item)
      .order("marketplace_sales.date DESC")
      .where("particle_id IS NOT NULL")
      .where(query_params)
  end
  
  def self.from_json(json)
    # create a clone so we do not modify the original object
    data = json.clone.deep_symbolize_keys
    
    # extract data from the sku
    parsed = ItemParser.parse_sku(data[:sku], data[:name])
    
    # add the parsed item to the data
    data.merge!(parsed.stringify_keys)
    
    # map related keys to column names
    {
      :name => :full_name,
      :id => :assetid,
      :original_id => :asset_original_id
    }.each do |k, v|
      data[v] = data[k]
    end
    
    # remove the id attribute
    data.delete(:id)
    
    # delete non-column keys before creating our record
    data = data.delete_if do |key, value|
      !MarketplaceSaleItem.column_names.include?(key.to_s)
    end
    
    MarketplaceSaleItem.new(data)
  end
end
