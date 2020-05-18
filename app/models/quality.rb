class Quality < ActiveRecord::Base
  establish_connection STEAM_DB
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("quality/all", :expires_in => 24.hours) { all.to_a } 
  end
  
  def self.find_by_name(value)
    all_cache.detect { |c| c.name == value }
  end
  
  def self.find_by_value(value)
    all_cache.detect { |c| c.value == value }
  end
  
  def self.find_by_color(value)
    all_cache.detect { |c| c.color.upcase == value.upcase }
  end
  
  def self.unknown
    Quality.new(:name => "Unknown")
  end
end
