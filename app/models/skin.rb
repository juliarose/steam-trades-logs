class Skin < ActiveRecord::Base
  establish_connection STEAM_DB
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("skin/all", :expires_in => 24.hours) { all.to_a } 
  end
  
  def self.find_by_name(value)
    all_cache.detect { |c| c.name == value }
  end
  
  def self.flush_all_cache
    @all_cache = nil
  end
  
  # array of all skin names
  def self.names
    all_cache.map(&:name)
  end
end
