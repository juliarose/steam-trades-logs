class ScmValue < ApplicationRecord
  monetize :value, as: :value_money
  
  validates_presence_of :date, :value
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("scm_values/all", :expires_in => 24.hours) { order("date DESC") } 
  end
  
  def self.flush_all_cache
    @all_cache = nil
  end
  
  def self.find_by_date(date)
    all_cache.find { |scm_value| date >= scm_value.date } || all_cache[0]
  end
end
