class BptfPrice < ApplicationRecord
  establish_connection STEAM_DB
  
  include Price
  
  has_one :item,
    :foreign_key => :defindex,
    :primary_key => :defindex
  has_one :quality,
    :foreign_key => :value,
    :primary_key => :quality_id,
    :class_name => :Quality
  
  def stats_url
    priceindexpath = self.priceindex if self.priceindex != 0
    australium_name = 'Australium' if self.australium
    
    paths = [
      self.quality.name,
      australium_name,
      self.item.item_name,
      self.tradableindex,
      self.craftableindex,
      priceindexpath
    ].compact
    
    return 'http://backpack.tf/stats/' + paths.join('/')
  end
  
  def tradableindex
    return self.tradable ? 'Tradable' : 'Non-Tradable'
  end
  
  def craftableindex
    return self.craftable ? 'Craftable' : 'Non-Craftable'
  end
end
