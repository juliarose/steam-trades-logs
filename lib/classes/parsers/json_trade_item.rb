require './lib/classes/parsers/app_data'

class JSONTradeItem
  include ActiveModel::Model
  
  attr_accessor :item_name, :full_name, :log_name, :appid, :contextid, :tradable, :icon_url, :value, :app_data
  
  def is_key
    item_name == 'Mann Co. Supply Crate Key'
  end
  
  def is_metal
    metal_value > 0
  end
  
  def metal_value
    if item_name == 'Refined Metal'
      9
    elsif item_name == 'Reclaimed Metal'
      3
    elsif item_name == 'Scrap Metal'
      1
    else  
      0
    end
  end
  
  def is_unusual
    !!(app_data && item.app_data[:quality] == 5)
  end
end