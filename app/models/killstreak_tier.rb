class KillstreakTier < ActiveRecord::Base
  establish_connection STEAM_DB
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("killstreak_tier/all", :expires_in => 24.hours) { all.to_a } 
  end
  
  def self.flush_all_cache
    @all_cache = nil
  end
  
  def self.find_by_value(float_value)
    all_cache.detect { |c| c.float_value == float_value }
  end
end
