module LogItem
  def log_name
    quality = Quality.find_by_value(self.quality_id) if self.quality_id
    particle = Particle.find_by_value(self.particle_id) if self.particle_id
    wear = Wear.find_by_value(self.wear_id) if self.wear_id
    prefix = (particle && particle.name) || (quality && quality.name)
    skin_name = self.skin_name
    item_name = self.item_name ? self.item_name : self.item && self.item.item_name
    wear_name = wear ? "(#{wear.name})" : nil
    
    [
      prefix,
      skin_name,
      item_name,
      wear_name
    ].compact.join(' ')
  end
end