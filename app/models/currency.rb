class Currency < ActiveRecord::Base
  establish_connection STEAM_DB
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch('currency/all', :expires_in => 30.minutes) { all.to_a }
  end

  def self.find_by_name(name)
    all_cache.detect { |c| c.name.downcase == name.downcase }
  end

  def self.flush_all_cache
    @all_cache = nil
  end
  
  def self.detect_symbol(str)
      return str.gsub(/[\d,.\s-]*/, '')
  end
  
  def self.s2f(str, fractional = false)
    # match price text
    str = str.match(/[\d,.]+/)
    
    if str
      str = str[0].gsub(',', '')
    end
    
    return str.to_f
  end
  
  def value_in_keys
    if self.name == 'keys'
      return 1
    else
      keys = Currency.find_by_name('keys')
      
      if keys && self.value_in_refined
        return self.value_in_refined / keys.value_in_refined
      end
    end
  end
  
  private
  
  def expire_cache
    Rails.cache.clear
  end
end
