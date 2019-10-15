class Series < ActiveRecord::Base
  establish_connection STEAM_DB
  
  has_many :effects,
    :foreign_key => :series_id,
    :primary_key => :value,
    :class_name => :AttributeControlledAttachedParticle
  
  belongs_to :attribute_controlled_attached_particle,
    :foreign_key => :value,
    :primary_key => :series_id,
    :class_name => :AttributeControlledAttachedParticle
  
  validates :value, :presence => true, :uniqueness => true
  validates :name, :presence => true
end
