class MarketplaceBot < ActiveRecord::Base
  establish_connection STEAM_DB
  
  validates :steamid, :presence => true, uniqueness: true
end
