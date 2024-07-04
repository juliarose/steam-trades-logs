class Currency < ActiveRecord::Base
  establish_connection STEAM_DB
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("currency/all", :expires_in => 30.minutes) { all.to_a }
  end

  def self.flush_all_cache
    @all_cache = nil
  end
  
  def self.find_by_name(name)
    all_cache.detect { |c| c.name.downcase == name.downcase }
  end
  
  def self.detect_symbol(str)
      str.gsub(/[\d,.\s-]*/, "")
  end
  
  def value_in_keys
    if self.name == "keys"
      return 1
    end
      
    keys = Currency.find_by_name("keys")
    
    if keys && self.value_in_refined
      self.value_in_refined / keys.value_in_refined
    end
  end
  
  private
  
  def expire_cache
    Rails.cache.clear
  end
end
