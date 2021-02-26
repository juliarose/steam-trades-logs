class BotOwnership < ActiveRecord::Base
  establish_connection STEAM_DB
  
  belongs_to :bot
  
  validates :steamid, :presence => true, uniqueness: true
  
  def self.unique_owners
    all.distinct(:steamid).uniq.map(&:steamid).uniq
  end
end
