module ItemParser
  # extracts the skin name from the full name using the name of the item
  # considering the name of the skin is prefixed before the item name
  # and followed by the name of the wear
  def self.parse_skin_name(full_name, item_name)
    # SKINS is a global variable containing an array of the names of all skins
    skin_names = Skin.names.sort_by { |a| -a.length }
    skin_name = skin_names.find do |name|
      # create a string which would belong in the name
      # e.g. "Low Profile SMG ("
      # the "(" is the beginning of the wear,
      # however for our purposes we do not need the name of the wear
      string = [name, item_name].join(" ") + " ("
      
      # should really be good enough
      # if it is not, oh well, I"ll need to rely on using the id"s for each skin
      full_name.include?(string)
    end
    
    skin_name
  end
  
  # takes a name from our logs and draws attributes from it
  def self.parse_sku(sku, full_name = nil)
    data = Hash.new
    attributes = sku.split(";")
    # the first attribute is the defindex
    defindex = attributes[0].to_i
    # the second is the quality
    quality_id = attributes[1].to_i
    # fetch the item to get more details for this item (its item name)
    item = Item.find_by_defindex(defindex)
    
    # raise exception if item is not found
    raise "Item with defindex #{defindex} is not in database" if item.nil?
    
    item_name = item.item_name
    # placeholder
    skin_name = nil
    
    maps = {
      "kt-" => "killstreak_tier_id",
      "u" => "particle_id",
      "w" => "wear_id",
      "pk" => "skin_id",
      "strange" => "strange",
      "australium" => "australium",
      "uncraftable" => "uncraftable",
      "festive" => "festive"
    }
    # these keys are integers
    integer_keys = [
      "killstreak_tier_id",
      "particle_id",
      "wear_id",
      "skin_id"
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
    
    if data["wear_id"] && full_name
      # we take the skin name from the full name
      skin_name = self.parse_skin_name(full_name, item_name)
    end
    
    {
      :item_name => item_name,
      :defindex => defindex,
      :appid => 440,
      :contextid => 2,
      :craftable => !data["uncraftable"],
      :quality_id => quality_id,
      :skin_name => skin_name
    }.merge(data.symbolize_keys)
  end
  
  # takes a name from our logs and draws attributes from it
  def self.parse_name(item_name, defindex = nil)
    # SKINS is a global variable containing an array of the names of all skins
    skin_names = Skin.names.sort_by { |a| -a.length }
    # these are all the wears
    wears = Wear.all_cache
    # these are all the particles
    particles = Particle.all_cache
    # these are the killstreak tiers
    killstreak_tiers = KillstreakTier.all_cache
    # find a particle with a matching name
    particle = particles.find do |a|
      a.visible && item_name.match(Regexp.new("^" + Regexp.escape(a.name) + " "))
    end
    
    killstreak_tier_names = killstreak_tiers.map(&:name).sort_by { |x| -x.length }
    killstreak_tier_pattern = Regexp.new(killstreak_tier_names.join("|"))
    killstreak_tier_match = item_name.match(killstreak_tier_pattern)
    
    # find a killstreak tier with a matching name
    if killstreak_tier_match
      killstreak_tier_name = killstreak_tier_match[0]
      killstreak_tier = killstreak_tiers.find { |a| a.name === killstreak_tier_name }
    end
    
    # remove festivized attribute from name
    # we don"t care about it
    item_name = item_name.gsub(/Festivized /, "")
    
    # default quality is unusual
    quality_id = 5
    quality = nil
    wear = nil
    australium = nil
    
    if item_name.match(/^Strange.*Australium .+/)
      # remove the australium part of the name
      item_name = item_name.gsub(/Australium /, "")
      # this is an australium item
      australium = true
    end
    
    if item_name.match(/^Strange /)
      # remove the strange prefix
      item_name = item_name.gsub(/^Strange /, "")
      # strange
      quality_id = 11
    end
    
    if item_name.match(/^Unusual /)
      # remove the prefix
      item_name = item_name.gsub(/^Unusual /, "")
      # but actually it"s unusual
      quality_id = 5
    end
    
    if killstreak_tier
      # remove the kilsltreak tier name
      item_name = item_name.gsub(killstreak_tier.name + " ", "")
    end
    
    if particle
      # remove the name of the particle
      item_name = item_name.gsub(Regexp.new("^" + Regexp.escape(particle.name) + " "), "")
    end
    
    # find the name of the skin
    skin_name = skin_names.find do |a|
      item_name.match(Regexp.new("^" + Regexp.escape(a) + " "))
    end
    
    if skin_name
      # remove the name of the skin
      item_name = item_name.gsub(Regexp.new("^" + Regexp.escape(skin_name) + " "), "")
      match = item_name.match(/\(([\w\-\s]+)\)/)
      
      if match
        # get the wear
        wear_name = match[1]
        item_name = item_name.gsub(match[0], "").strip
        wear = wears.find { |a| a.name === wear_name }
      end
    end
    
    quality = Quality.find_by_value(quality_id)
    item = defindex ? Item.find_by_defindex(defindex) : Item.find_by_item_name(item_name)
    
    {
      :item_name => item && item.item_name,
      :defindex => item && item.defindex,
      :appid => 440,
      :contextid => 2,
      :craftable => true,
      :australium => !!australium,
      :quality_id => quality && quality.value,
      :killstreak_tier_id => killstreak_tier && killstreak_tier.float_value,
      :wear_id => wear && wear.value,
      :particle_id => particle && particle.value,
      :skin_name => skin_name
    }
  end
end