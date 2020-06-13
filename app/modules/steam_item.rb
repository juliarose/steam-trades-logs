module SteamItem
  
  def image_url
    item = self.item
    
    return nil unless item
    
    if self.skin_name
      skin = Skin.find_by_name(self.skin_name)
      wear_id = self.wear_id || 3
      
      return "https://scrap.tf/img/items/warpaint/#{CGI::escape(item.item_name)}_#{skin.value}_#{wear_id}_0.png" if skin
    end
    
    if self.australium && item.australium_image
      return "https://steamcommunity-a.akamaihd.net/economy/image/#{item.australium_image}/94fx94x"
    end
    
    item.image_url
  end
  
  def particle_url
    "https://backpack.tf/images/440/particles/#{self.particle_id}_94x94.png" if self.particle_id
  end
end