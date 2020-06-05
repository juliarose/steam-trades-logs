module SteamTradeItemsHelper
  
  # groups steam trade items by appid, then by name
  def group_steam_trade_items(steam_trade_items)
    grouped_by_appid = steam_trade_items.group_by do |steam_trade_item|
      steam_trade_item.appid
    end
    
    grouped_by_appid.each do |k, v|
      grouped_by_appid[k] = v.group_by do |steam_trade_item|
        steam_trade_item.full_name
      end
    end
  end
  
  # gets the classes for an element
  def get_steam_trade_item_class(steam_trade_item)
    classes = ["steam-trade-item"]
    
    if !steam_trade_item.craftable
      classes.push("nocraft")
    end
    
    # not all objects will have this property
    if steam_trade_item.strange
      classes.push("strange")
    end
    
    if steam_trade_item.quality_id
      classes.push("q-#{steam_trade_item.appid}-#{steam_trade_item.quality_id}")
    end
    
    classes
  end
  
  # gets the query for an item
  def get_steam_trade_query(steam_trade_item)
    strange = steam_trade_item.try(:strange) ? steam_trade_item.strange : nil
    craftable = steam_trade_item.try(:craftable) ? steam_trade_item.craftable : nil
    
    {
      :quality => steam_trade_item.quality_id,
      :defindex => steam_trade_item.defindex,
      :particle => steam_trade_item.particle_id,
      :craftable => craftable ? 1 : 0,
      :strange => strange ? 1 : 0,
      :australium => steam_trade_item.australium ? 1 : 0,
      :skin_name => steam_trade_item.skin_name
    }.compact
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
