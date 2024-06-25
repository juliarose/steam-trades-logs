class MarketplaceBot < ActiveRecord::Base
  establish_connection STEAM_DB
  
  validates :steamid, :presence => true, uniqueness: true
    
  def self.all
      @all_cache ||= Rails.cache.fetch('marketplace_bot/all', :expires_in => 24.hours) { super } 
  end
  
  def self.flush_all_cache
      @all_cache = nil
  end
end
