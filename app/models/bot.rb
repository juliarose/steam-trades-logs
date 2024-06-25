class Bot < ApplicationRecord
  establish_connection STEAM_DB
  
  has_many :steam_trades,
    :primary_key => :uid,
    :foreign_key => :steamid
    
    def self.all
        @all_cache ||= Rails.cache.fetch('bot/all', :expires_in => 24.hours) { super } 
    end
    
    def self.flush_all_cache
        @all_cache = nil
    end
end
