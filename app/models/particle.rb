class Particle < ActiveRecord::Base
  establish_connection STEAM_DB
  
  scope :visible, -> { where(visible: true) }
  
  has_one :series,
    :foreign_key => :value,
    :primary_key => :series_id,
    :class_name => :Series
  belongs_to :series,
    :foreign_key => :series_id,
    :primary_key => :value
  has_many :bptf_prices, -> { where quality_id: 5 },
    :class_name => :BptfPrice,
    :primary_key => :value,
    :foreign_key => :priceindex
  
  def self.all_cache
    @all_cache ||= Rails.cache.fetch("particle/all", :expires_in => 24.hours) { all.to_a } 
  end
  
  def self.find_by_value(value)
    all_cache.detect { |c| c.value == value }
  end
  
  def self.find_by_name(value)
    all_cache.detect { |c| c.name == value }
  end
  
  def self.flush_all_cache
    @all_cache = nil
  end
  
  def self.unknown(options = {})
    Particle.new(options.merge(:value => 0, :name => "Unknown"))
  end
  
  def visible
    read_attribute(:visible) && !self.image.nil?
  end
end
