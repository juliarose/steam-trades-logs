class Item < ApplicationRecord
  establish_connection STEAM_DB
end
