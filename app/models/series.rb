class Series < ActiveRecord::Base
  establish_connection STEAM_DB
  
  has_many :particles,
    :foreign_key => :series_id,
    :primary_key => :value
  
  belongs_to :particle,
    :foreign_key => :value,
    :primary_key => :series_id
  
  validates :value, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
