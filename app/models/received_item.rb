class ReceivedItem < ApplicationRecord
  belongs_to :steam_trade
  belongs_to :steam_trade_item, dependent: :destroy
end
