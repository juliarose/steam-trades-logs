class Bot < ApplicationRecord
  establish_connection STEAM_DB
  
  has_many :steam_trades,
    :primary_key => :uid,
    :foreign_key => :steamid
end
