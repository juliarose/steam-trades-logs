module MarketplaceSkuParser
  
  # extracts the skin name from the full name using the name of the item
  # considering the name of the skin is prefixed before the item name
  # and followed by the name of the wear
  def parse_skin_name(full_name, item_name)
    # SKINS is a global variable containing an array of the names of all skins
    skin_names = SKINS.sort_by { |a| -a.length }
    skin_name = skin_names.find do |name|
      # create a string which would belong in the name
      # e.g. "Low Profile SMG ("
      # the "(" is the beginning of the wear,
      # however for our purposes we do not need the name of the wear
      string = [name, item_name].join(' ') + ' ('
      
      # should really be good enough
      # if it is not, oh well, I'll need to rely on using the id's for each skin
      full_name.include?(string)
    end
    
    skin_name
  end
  
  # takes a name from our logs and draws attributes from it
  def parse_sku(sku, full_name = nil)
    data = Hash.new
    attributes = sku.split(';')
    # the first attribute is the defindex
    defindex = attributes[0].to_i
    # the second is the quality
    quality_id = attributes[1].to_i
    # fetch the item to get more details for this item (its item name)
    item = Item.find_by_defindex(defindex)
    item_name = item.item_name
    # placeholder
    skin_name = nil
    
    maps = {
      'kt-' => 'killstreak_tier_id',
      'u' => 'particle_id',
      'w' => 'wear_id',
      'pk' => 'skin_id',
      'australium' => 'australium',
      'uncraftable' => 'uncraftable',
      'festive' => 'festive'
    }
    # these keys are integers
    integer_keys = [
      'killstreak_tier_id',
      'particle_id',
      'wear_id',
      'skin_id'
    ]
    
    # loop through each attribute past the first 2, which are the defindex and quality
    attributes.drop(2).each do |attribute|
      pattern = Regexp.new(/^([A-z\-]+)(\d+)?$/)
      match = attribute.match(pattern)
      
      if match
        name = match[1]
        value = match[2]
        key = maps[name]
        
        if key
          if integer_keys.include?(key)
            # the value should be expressed as an integer
            value = value.to_i
          else
            # otherwise the value is just a boolean (attribute exists)
            value = true
          end
          
          # add the attribute to the data object
          data[key] = value
        end
      end
    end
    
    if data['wear_id'] && full_name
      # we take the skin name from the full name
      skin_name = parse_skin_name(full_name, item_name)
    end
    
    {
      :item_name => item_name,
      :defindex => defindex,
      :appid => 440,
      :contextid => 2,
      :craftable => !data['uncraftable'],
      :quality_id => quality_id,
      :skin_name => skin_name
    }.merge(data.symbolize_keys)
  end
end