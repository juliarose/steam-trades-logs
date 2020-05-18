module LogItem
  def log_name
    quality = Quality.find_by_value(self.quality_id) if self.quality_id && self.quality_id != 6
    particle = Particle.find_by_value(self.particle_id) if self.particle_id
    killstreak_tier = KillstreakTier.find_by_value(self.killstreak_tier_id) if self.killstreak_tier_id
    wear = Wear.find_by_value(self.wear_id) if self.wear_id
    
    killstreak_tier_name = killstreak_tier.name if killstreak_tier
    item_name = self.item_name ? self.item_name : self.item && self.item.item_name
    wear_name = "(#{wear.name})" if wear
    skin_name = self.skin_name
    australium_name = "Australium" if self.australium
    
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