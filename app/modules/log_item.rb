module LogItem
  
  def sold_at
    if self.is_a?(SteamTradeItem)
      return self.steam_trade.traded_at
    elsif self.is_a?(MarketListing)
      return self.date_acted
    elsif self.is_a?(MarketplaceSaleItem)
      return self.marketplace_sale.date
    elsif self.is_a?(SteamTrade)
      return self.traded_at
    end
  end
  
  def log_name
    LogItem.log_name(self)
  end
  
  def self.log_name(item)
    quality = Quality.find_by_value(item.quality_id) if item.quality_id && item.quality_id != 6
    particle = Particle.find_by_value(item.particle_id) if item.particle_id
    killstreak_tier = KillstreakTier.find_by_value(item.killstreak_tier_id) if item.killstreak_tier_id
    wear = Wear.find_by_value(item.wear_id) if item.wear_id
    
    killstreak_tier_name = killstreak_tier.name if killstreak_tier
    item_name = item.item_name ? item.item_name : item.item && item.item.item_name
    wear_name = "(#{wear.name})" if wear
    skin_name = item.skin_name
    australium_name = "Australium" if item.australium
    
    [
      (particle && particle.name) || (quality && quality.name),
      killstreak_tier_name,
      australium_name,
      skin_name,
      item_name,
      wear_name
    ].compact.join(" ")
  end
end