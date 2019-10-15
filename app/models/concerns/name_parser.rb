module NameParser
  # takes a name from our logs and draws attributes from it
  def parse_name(item_name)
    # SKINS is a global variable containing an array of the names of all skins
    skin_names = SKINS.sort_by { |a| -a.length }
    # these are all the wears
    wears = Wear.all_cache
    # these are all the particles
    particles = Particle.all_cache
    # these are the killstreak tiers
    killstreak_tiers = KillstreakTier.all_cache
    # find a particle with a matching name
    particle = particles.find do |a|
      a.visible && item_name.match(Regexp.new('^' + Regexp.escape(a.name) + ' '))
    end
    
    killstreak_tier_names = killstreak_tiers.map(&:name).sort_by { |x| -x.length }
    killstreak_tier_pattern = Regexp.new(killstreak_tier_names.join('|'))
    killstreak_tier_match = item_name.match(killstreak_tier_pattern)
    
    # find a killstreak tier with a matching name
    if killstreak_tier_match
      killstreak_tier_name = killstreak_tier_match[0]
      killstreak_tier = killstreak_tiers.find { |a| a.name === killstreak_tier_name }
    end
    
    # remove festivized attribute from name
    # we don't care about it
    item_name = item_name.gsub(/Festivized /, '')
    
    # default quality is unusual
    quality_id = 5
    quality = nil
    wear = nil
    
    if item_name.match(/^Strange /)
      # remove the strange prefix
      item_name = item_name.gsub(/^Strange /, '')
      # strange
      quality_id = 11
    end
    
    if item_name.match(/^Unusual /)
      # remove the prefix
      item_name = item_name.gsub(/^Unusual /, '')
      # but actually it's unusual
      quality_id = 5
    end
    
    if killstreak_tier
      # remove the kilsltreak tier name
      item_name = item_name.gsub(killstreak_tier.name + ' ', '')
    end
    
    if particle
      # remove the name of the particle
      item_name = item_name.gsub(Regexp.new('^' + Regexp.escape(particle.name) + ' '), '')
    end
    
    # find the name of the skin
    skin_name = skin_names.find do |a|
      item_name.match(Regexp.new('^' + Regexp.escape(a) + ' '))
    end
    
    if skin_name
      # remove the name of the skin
      item_name = item_name.gsub(Regexp.new('^' + Regexp.escape(skin_name) + ' '), '')
      match = item_name.match(/\(([\w\-\s]+)\)/)
      
      if match
        # get the wear
        wear_name = match[1]
        item_name = item_name.gsub(match[0], '').strip
        wear = wears.find { |a| a.name === wear_name }
      end
    end
    
    quality = Quality.find_by_value(quality_id)
    item = Item.find_by_item_name(item_name)
    
    {
      :item_name => item && item.item_name,
      :defindex => item && item.defindex,
      :appid => 440,
      :contextid => 2,
      :craftable => true,
      :quality_id => quality && quality.value,
      :killstreak_tier_id => killstreak_tier && killstreak_tier.float_value,
      :wear_id => wear && wear.value,
      :particle_id => particle && particle.value,
      :skin_name => skin_name
    }
  end
end