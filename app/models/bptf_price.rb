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
    priceindex = self.priceindex unless self.priceindex === 0
    
    "http://backpack.tf/stats/" + [
      self.quality.name,
      self.australium_name,
      self.item.item_name,
      self.tradable_name,
      self.craftable_name,
      priceindex
    ].join("/")
  end
  
  def austalium_name
    "Australium" if self.australium
  end
  
  def tradable_name
    self.tradable ? "Tradable" : "Non-Tradable"
  end
  
  def craftable_name
    self.craftable ? "Craftable" : "Non-Craftable"
  end
end
