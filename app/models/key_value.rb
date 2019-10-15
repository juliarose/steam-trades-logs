class KeyValue < ApplicationRecord
  
  validates_presence_of :date, :value
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch('key_values/all', :expires_in => 24.hours) { order('date DESC') } 
  end
  
  def self.find_by_date(date)
    all_cache.find { |key_value| date >= key_value.date }
  end
  
  def self.flush_all_cache
    @all_cache = nil
  end
end
