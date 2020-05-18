module SteamTradeItemsHelper
  
  # groups steam trade items by appid, then by name
  def group_steam_trade_items(steam_trade_items)
    grouped_by_appid = steam_trade_items.group_by { |steam_trade_item| steam_trade_item.appid }
    grouped_by_appid.each do |k, v|
      grouped_by_appid[k] = v.group_by { |steam_trade_item| steam_trade_item.full_name }
    end
  end
  
  # gets the classes for an element
  def get_steam_trade_item_class(steam_trade_item)
    classes = ["steam-trade-item"]
    
    if steam_trade_item.quality_id
      classes.push("q-#{steam_trade_item.appid}-#{steam_trade_item.quality_id}")
    end
    
    classes
  end
  
  # gets the styles for an element
  def get_steam_trade_style(steam_trade_item)
    background_images = []
    
    if steam_trade_item.item && steam_trade_item.image_url
      background_images.push(steam_trade_item.image_url)
    end
    
    if steam_trade_item.particle_url
      background_images.push(steam_trade_item.particle_url) 
    end
    
    {
      "background-image": background_images.map { |url| "url('#{url}')" }.join(", ")
    }
      .select { |name, value| value && value.length > 0 }
      .map { |name, value| "#{name}: #{value}" }
  end
end
